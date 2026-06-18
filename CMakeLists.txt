# SPDX-License-Identifier: GPL-3.0-or-later
cmake_minimum_required(VERSION 3.16)

project(apoplexy
	VERSION 3.18.0
	LANGUAGES C)

option(APOPLEXY_USE_STATIC_PKGCONFIG
	"Use pkg-config static dependency link flags" OFF)
option(APOPLEXY_BUILD_APP
	"Build the apoplexy executable" ON)
option(APOPLEXY_BUILD_PR
	"Build the Princed Resources helper" ON)

set(APOPLEXY_EXTRA_CPPCHECK_FLAGS "" CACHE STRING
	"Extra flags passed to the cppcheck target")

if(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Build type" FORCE)
endif()

if(APOPLEXY_BUILD_APP)
	add_executable(apoplexy src/apoplexy.c)
	if(WIN32)
		enable_language(RC)
		target_include_directories(apoplexy PRIVATE "${PROJECT_SOURCE_DIR}")
		target_sources(apoplexy PRIVATE src/apoplexy.rc)
	endif()

	set_target_properties(apoplexy PROPERTIES
		C_STANDARD 99
		C_STANDARD_REQUIRED ON
		C_EXTENSIONS OFF
		RUNTIME_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}")

	if(CMAKE_CONFIGURATION_TYPES)
		foreach(sConfig ${CMAKE_CONFIGURATION_TYPES})
			string(TOUPPER "${sConfig}" sConfigUpper)
			set_target_properties(apoplexy PROPERTIES
				"RUNTIME_OUTPUT_DIRECTORY_${sConfigUpper}" "${PROJECT_SOURCE_DIR}")
		endforeach()
	endif()

	if(CMAKE_C_COMPILER_ID MATCHES "GNU|Clang|AppleClang")
		target_compile_options(apoplexy PRIVATE
			-Wno-unused-result
			-pedantic
			-Wall
			-Wextra
			-Wshadow
			-Wpointer-arith
			-Wcast-qual
			-Wstrict-prototypes
			-Wmissing-prototypes)
	endif()

	if(CMAKE_C_COMPILER_ID MATCHES "Clang|AppleClang")
		target_compile_options(apoplexy PRIVATE
			-Wno-nullability-extension)
	endif()

	if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
		target_compile_options(apoplexy PRIVATE
			-Wno-format-truncation
			-Wno-stringop-overflow)
	endif()

	find_package(PkgConfig REQUIRED)
endif()

function(apoplexy_configure_macos_vcpkg_pkgconfig)
	if(NOT APPLE)
		return()
	endif()

	if(CMAKE_SYSTEM_PROCESSOR STREQUAL "arm64")
		set(sVcpkgTriplet "arm64-osx")
	else()
		set(sVcpkgTriplet "x64-osx")
	endif()

	set(sVcpkgPkgConfig
		"${PROJECT_SOURCE_DIR}/vcpkg_installed/${sVcpkgTriplet}/lib/pkgconfig")

	if(EXISTS "${sVcpkgPkgConfig}/sdl2.pc")
		if(DEFINED ENV{PKG_CONFIG_PATH}
			AND NOT "$ENV{PKG_CONFIG_PATH}" STREQUAL "")
			set(ENV{PKG_CONFIG_PATH}
				"${sVcpkgPkgConfig}:$ENV{PKG_CONFIG_PATH}")
		else()
			set(ENV{PKG_CONFIG_PATH} "${sVcpkgPkgConfig}")
		endif()

		set(APOPLEXY_USE_STATIC_PKGCONFIG ON CACHE BOOL
			"Use pkg-config static dependency link flags" FORCE)
	endif()
endfunction()

function(apoplexy_apply_pkg_config sTarget sPrefix)
	if(APOPLEXY_USE_STATIC_PKGCONFIG)
		set(sSuffix "_STATIC")
	else()
		set(sSuffix "")
	endif()

	set(sIncludeDirs "${sPrefix}_INCLUDE_DIRS")
	set(sCFlagsOther "${sPrefix}_CFLAGS_OTHER")
	set(sLibraryDirs "${sPrefix}${sSuffix}_LIBRARY_DIRS")
	set(sLibraries "${sPrefix}${sSuffix}_LIBRARIES")
	set(sLDFlagsOther "${sPrefix}${sSuffix}_LDFLAGS_OTHER")

	if(${sIncludeDirs})
		target_include_directories(${sTarget} PRIVATE ${${sIncludeDirs}})
	endif()
	if(${sCFlagsOther})
		target_compile_options(${sTarget} PRIVATE ${${sCFlagsOther}})
	endif()
	if(${sLibraryDirs})
		target_link_directories(${sTarget} PRIVATE ${${sLibraryDirs}})
	endif()
	if(${sLibraries})
		target_link_libraries(${sTarget} PRIVATE ${${sLibraries}})
	endif()
	if(${sLDFlagsOther})
		target_link_options(${sTarget} PRIVATE ${${sLDFlagsOther}})
	endif()
endfunction()

if(APOPLEXY_BUILD_APP)
	apoplexy_configure_macos_vcpkg_pkgconfig()
	pkg_check_modules(APOPLEXY_SDLZIP REQUIRED
		SDL2_image
		SDL2_ttf
		libzip
		sdl2)
	apoplexy_apply_pkg_config(apoplexy APOPLEXY_SDLZIP)

	if(APPLE)
		find_package(CURL REQUIRED)
		target_link_libraries(apoplexy PRIVATE CURL::libcurl)
	endif()
	if(NOT APPLE)
		pkg_check_modules(APOPLEXY_CURL libcurl)
		if(APOPLEXY_CURL_FOUND)
			apoplexy_apply_pkg_config(apoplexy APOPLEXY_CURL)
		else()
			find_package(CURL REQUIRED)
			target_link_libraries(apoplexy PRIVATE CURL::libcurl)
		endif()
	endif()

	if(NOT MSVC AND NOT APPLE)
		target_link_libraries(apoplexy PRIVATE m)
	endif()
endif()

if(APOPLEXY_BUILD_PR)
	include(cmake/PrincedResources.cmake)
endif()

if(APOPLEXY_BUILD_APP AND APOPLEXY_BUILD_PR)
	add_dependencies(apoplexy pr_helper pr_runtime_files)
endif()

find_program(CPPCHECK_EXECUTABLE NAMES cppcheck)
set(APOPLEXY_CPPCHECK_FLAGS
	--language=c
	--std=c99
	--verbose
	--max-configs=1
	--enable=warning,performance,portability
	--inline-suppr
	--error-exitcode=1)

set(APOPLEXY_EXTRA_CPPCHECK_FLAGS_LIST "")
if(NOT APOPLEXY_EXTRA_CPPCHECK_FLAGS STREQUAL "")
	separate_arguments(APOPLEXY_EXTRA_CPPCHECK_FLAGS_LIST NATIVE_COMMAND
		"${APOPLEXY_EXTRA_CPPCHECK_FLAGS}")
endif()

if(CPPCHECK_EXECUTABLE)
	add_custom_target(cppcheck
		COMMAND "${CPPCHECK_EXECUTABLE}"
			${APOPLEXY_CPPCHECK_FLAGS}
			${APOPLEXY_EXTRA_CPPCHECK_FLAGS_LIST}
			apoplexy.c
		WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}/src"
		COMMENT "Running cppcheck"
		VERBATIM)
else()
	add_custom_target(cppcheck
		COMMAND "${CMAKE_COMMAND}" -E echo "cppcheck was not found"
		COMMAND "${CMAKE_COMMAND}" -E false
		COMMENT "Running cppcheck"
		VERBATIM)
endif()
