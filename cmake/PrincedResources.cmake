# SPDX-License-Identifier: GPL-3.0-or-later

set(APOPLEXY_PR_SOURCE_DIR "${PROJECT_SOURCE_DIR}/third_party/PR/src")
set(APOPLEXY_PR_RUNTIME_DIR "${PROJECT_SOURCE_DIR}/pr")

if(NOT EXISTS "${APOPLEXY_PR_SOURCE_DIR}/lib/pr.c")
	message(FATAL_ERROR
		"Princed Resources submodule is not initialized. "
		"Run `git submodule update --init --recursive` from the "
		"repository root.")
endif()

set(APOPLEXY_PR_SOURCES
	"${APOPLEXY_PR_SOURCE_DIR}/lib/pr.c"
	"${APOPLEXY_PR_SOURCE_DIR}/console/main.c"
	"${APOPLEXY_PR_SOURCE_DIR}/console/filedir.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/xml/parse.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/xml/search.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/xml/unknown.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/xml/translate.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/xml/tree.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/compression/lzg_compress.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/compression/lzg_uncompress.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/compression/rle_compress.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/compression/rle_uncompress.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/compression/rlec_compress.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/compression/rlec_uncompress.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/compression/bitfield.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/actions/import.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/actions/export.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/actions/classify.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/layers/dat.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/layers/memory.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/layers/list.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/layers/reslist.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/layers/pallist.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/layers/disk.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/layers/idlist.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/layers/autodetect.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/layers/stringformat.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/layers/resourcematch.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/layers/auxiliary.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/object/main.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/object/palette/pop2_256c.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/object/palette/pop1_4bit.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/object/palette/pop2_4bit.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/object/image/image2.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/object/image/image16.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/object/image/image256.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/object/other/binary.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/object/sound/sounds.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/object/level/level.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/object/text/text.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/formats/bmp.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/formats/mid.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/formats/pal.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/formats/wav.c"
	"${APOPLEXY_PR_SOURCE_DIR}/lib/formats/plv.c")

if(NOT CMAKE_SYSTEM_NAME STREQUAL "Linux")
	list(APPEND APOPLEXY_PR_SOURCES
		"${APOPLEXY_PR_SOURCE_DIR}/ports/getopt.c"
		"${APOPLEXY_PR_SOURCE_DIR}/ports/getopt1.c")
endif()

add_executable(pr_helper ${APOPLEXY_PR_SOURCES})
target_include_directories(pr_helper PRIVATE "${APOPLEXY_PR_SOURCE_DIR}/include")
set_target_properties(pr_helper PROPERTIES
	C_STANDARD 99
	C_STANDARD_REQUIRED ON
	C_EXTENSIONS ON
	RUNTIME_OUTPUT_DIRECTORY "${APOPLEXY_PR_RUNTIME_DIR}")

if(CMAKE_CONFIGURATION_TYPES)
	foreach(sConfig ${CMAKE_CONFIGURATION_TYPES})
		string(TOUPPER "${sConfig}" sConfigUpper)
		set_target_properties(pr_helper PROPERTIES
			"RUNTIME_OUTPUT_DIRECTORY_${sConfigUpper}" "${APOPLEXY_PR_RUNTIME_DIR}")
	endforeach()
endif()

if(WIN32)
	set_target_properties(pr_helper PROPERTIES OUTPUT_NAME pr)
	target_compile_definitions(pr_helper PRIVATE WIN32 NOLINUX "OS=\"Win32\"")
elseif(APPLE)
	set_target_properties(pr_helper PROPERTIES OUTPUT_NAME pr-darwin)
	target_compile_definitions(pr_helper PRIVATE NOLINUX "OS=\"Darwin\"")
else()
	set_target_properties(pr_helper PROPERTIES OUTPUT_NAME pr)
	target_compile_definitions(pr_helper PRIVATE LINUX "OS=\"GNU/Linux\"")
endif()

if(CMAKE_C_COMPILER_ID MATCHES "GNU|Clang|AppleClang")
	target_compile_options(pr_helper PRIVATE -Wno-implicit-function-declaration)
endif()

set(APOPLEXY_PR_RESOURCES_XML "${APOPLEXY_PR_RUNTIME_DIR}/resources.xml")
set(APOPLEXY_PR_POP2_XML "${APOPLEXY_PR_RUNTIME_DIR}/pop2.xml")

add_custom_command(
	OUTPUT
		"${APOPLEXY_PR_RESOURCES_XML}"
		"${APOPLEXY_PR_POP2_XML}"
	COMMAND "${CMAKE_COMMAND}" -E make_directory "${APOPLEXY_PR_RUNTIME_DIR}"
	COMMAND "${CMAKE_COMMAND}" -E copy_if_different
		"${APOPLEXY_PR_SOURCE_DIR}/xml/resources.xml"
		"${APOPLEXY_PR_RESOURCES_XML}"
	COMMAND "${CMAKE_COMMAND}" -E copy_if_different
		"${APOPLEXY_PR_SOURCE_DIR}/xml/pop2.xml"
		"${APOPLEXY_PR_POP2_XML}"
	DEPENDS
		"${APOPLEXY_PR_SOURCE_DIR}/xml/resources.xml"
		"${APOPLEXY_PR_SOURCE_DIR}/xml/pop2.xml"
	COMMENT "Copying Princed Resources runtime XML"
	VERBATIM)

add_custom_target(pr_runtime_files ALL
	DEPENDS
		"${APOPLEXY_PR_RESOURCES_XML}"
		"${APOPLEXY_PR_POP2_XML}")
