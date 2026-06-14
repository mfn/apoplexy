#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Build apoplexy for 32-bit Windows from an MSYS2 MINGW32 shell.
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root"

if [[ "${MSYSTEM-}" != "MINGW32" ]]; then
	printf '%s\n' \
		"scripts/build-windows-msys2.sh must run in an MSYS2 MINGW32 shell." \
		>&2
	exit 1
fi

aPkg=(sdl2 SDL2_image SDL2_ttf libcurl libzip)
aPkgLibs=(SDL2_image SDL2_ttf libcurl libzip sdl2)

pkg-config --print-errors --exists "${aPkg[@]}"
read -r -a aPkgCFlags <<< "$(pkg-config --cflags "${aPkg[@]}")"
read -r -a aPkgLFlags <<< "$(pkg-config --libs "${aPkgLibs[@]}")"

gcc \
	-O2 \
	-Wno-unused-result \
	-std=c99 \
	-g \
	-pedantic \
	-Wall \
	-Wextra \
	-Wshadow \
	-Wpointer-arith \
	-Wcast-qual \
	-Wstrict-prototypes \
	-Wmissing-prototypes \
	-D_REENTRANT \
	"${aPkgCFlags[@]}" \
	src/apoplexy.c \
	-o apoplexy.exe \
	"${aPkgLFlags[@]}" \
	-lm \
	-Wno-format-truncation \
	-Wno-stringop-overflow
