#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Build apoplexy for 64-bit Windows from an MSYS2 UCRT64 shell with CMake.
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

if [[ "${MSYSTEM-}" != "UCRT64" ]]; then
	printf '%s\n' \
		"scripts/build-windows-msys2.sh must run in an MSYS2 UCRT64 shell." \
		>&2
	exit 1
fi

if ! command -v cmake >/dev/null 2>&1; then
	printf '%s\n' \
		"cmake was not found. Install mingw-w64-ucrt-x86_64-cmake." \
		>&2
	exit 1
fi

build_dir="$repo_root/build/windows-ucrt64"
cmake \
	-S "$repo_root" \
	-B "$build_dir" \
	-G Ninja \
	-DCMAKE_BUILD_TYPE=RelWithDebInfo
exec cmake --build "$build_dir"
