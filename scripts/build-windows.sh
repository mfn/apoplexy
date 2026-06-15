#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Build apoplexy for 64-bit Windows using vcpkg (MSVC) and CMake.
# Run from Git Bash or any bash shell on a machine with Visual Studio 2022.
#
# Honors $VCPKG_ROOT if set; otherwise auto-clones vcpkg into ./.vcpkg/.
# The GitHub Actions pre-installed C:\vcpkg is intentionally not used: it is
# built from a different vcpkg commit that requires cmake 4.x, whereas our
# baseline only requires cmake 3.7.2.
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

if ! command -v cmake >/dev/null 2>&1; then
	printf '%s\n' \
		"cmake was not found. Install Visual Studio 2022 with the C++ workload." \
		>&2
	exit 1
fi

if [[ -n "${VCPKG_ROOT-}" ]] && \
   [[ -x "${VCPKG_ROOT}/vcpkg.exe" || -x "${VCPKG_ROOT}/vcpkg" ]]; then
	vcpkg_root="$VCPKG_ROOT"
else
	vcpkg_root="$repo_root/.vcpkg"
	if [[ ! -x "$vcpkg_root/vcpkg.exe" ]]; then
		git clone --depth=1 https://github.com/microsoft/vcpkg "$vcpkg_root"
		powershell.exe -NoProfile -ExecutionPolicy Bypass \
			-File "$(cygpath -w "$vcpkg_root/scripts/bootstrap.ps1")" \
			-disableMetrics
	fi
fi

vcpkg_exe="$vcpkg_root/vcpkg.exe"
[[ -x "$vcpkg_exe" ]] || vcpkg_exe="$vcpkg_root/vcpkg"

"$vcpkg_exe" install \
	--triplet x64-windows \
	"--x-manifest-root=$(cygpath -w "$repo_root")" \
	"--x-install-root=$(cygpath -w "$repo_root/vcpkg_installed")"

build_dir="$repo_root/build/windows-x64"
cmake \
	-S "$repo_root" \
	-B "$build_dir" \
	-G "Visual Studio 17 2022" \
	-A x64 \
	"-DCMAKE_TOOLCHAIN_FILE=$(cygpath -w "$vcpkg_root/scripts/buildsystems/vcpkg.cmake")" \
	-DVCPKG_TARGET_TRIPLET=x64-windows \
	"-DVCPKG_INSTALLED_DIR=$(cygpath -w "$repo_root/vcpkg_installed")"
exec cmake --build "$build_dir" --config RelWithDebInfo
