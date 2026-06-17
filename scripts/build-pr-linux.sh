#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Build Princed Resources (PR) natively with the repository CMake target.
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
build_dir="$repo_root/build/pr-linux"
output="$repo_root/pr/pr"

if ! command -v cmake >/dev/null 2>&1; then
	printf '%s\n' "cmake was not found." >&2
	exit 1
fi

cmake \
	-S "$repo_root" \
	-B "$build_dir" \
	-DCMAKE_BUILD_TYPE=RelWithDebInfo \
	-DAPOPLEXY_BUILD_APP=OFF
cmake --build "$build_dir" --target pr_helper pr_runtime_files >/dev/null

printf '%s\n' "$output"
