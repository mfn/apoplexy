#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Build Princed Resources (PR) natively for Linux release packages.
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
pr_zip="$repo_root/pr/PR-1.3.1-prerelease.ZIP"
build_dir="$repo_root/build/pr-linux"
output="$build_dir/pr"

if ! command -v unzip >/dev/null 2>&1; then
	printf '%s\n' "unzip was not found." >&2
	exit 1
fi
if ! command -v make >/dev/null 2>&1; then
	printf '%s\n' "make was not found." >&2
	exit 1
fi

rm -rf "$build_dir"
mkdir -p "$build_dir"
unzip -q "$pr_zip" -d "$build_dir"
make -C "$build_dir/PR-1.3.1-prerelease/src" RELEASE="-O3 -fcommon" all >/dev/null
cp "$build_dir/PR-1.3.1-prerelease/src/bin/pr" "$output"
chmod +x "$output"

printf '%s\n' "$output"
