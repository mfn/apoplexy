#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Build apoplexy natively on macOS using a project-local vcpkg.
# Resolves SDL2/SDL2_image/SDL2_ttf/libzip from vcpkg.json into
# ./vcpkg_installed/, then builds apoplexy and the Princed Resources (PR)
# helper from third_party/PR with CMake.
#
# Honors $VCPKG_ROOT if set (opt-out for users with a shared vcpkg);
# otherwise auto-clones vcpkg into ./.vcpkg/ on first run.
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

if ! command -v cmake >/dev/null 2>&1; then
	echo "cmake was not found. Install it with: brew install cmake" >&2
	exit 1
fi

if ! command -v pkg-config >/dev/null 2>&1; then
	echo "pkg-config was not found. Install it with: brew install pkg-config" >&2
	exit 1
fi

if [[ -n "${VCPKG_ROOT-}" && -x "$VCPKG_ROOT/vcpkg" ]]; then
	vcpkg_root="$VCPKG_ROOT"
else
	vcpkg_root="$repo_root/.vcpkg"
	if [[ ! -x "$vcpkg_root/vcpkg" ]]; then
		git init "$vcpkg_root"
		git -C "$vcpkg_root" fetch --depth=1 https://github.com/microsoft/vcpkg f3e10653cc27d62a37a3763cd84b38bca07c6075
		git -C "$vcpkg_root" checkout FETCH_HEAD
		"$vcpkg_root/bootstrap-vcpkg.sh" -disableMetrics
	fi
fi

"$vcpkg_root/vcpkg" install \
	--x-manifest-root="$repo_root" \
	--x-install-root="$repo_root/vcpkg_installed"

case "$(uname -m)" in
	arm64)  triplet=arm64-osx ;;
	x86_64) triplet=x64-osx   ;;
	*) echo "unsupported arch: $(uname -m)" >&2; exit 1 ;;
esac
prefix="$repo_root/vcpkg_installed/$triplet"

# vcpkg's macOS triplets produce static libs (.a). Ask CMake to consume the
# pkg-config --static dependency set so SDL2_image/SDL2_ttf/libzip bring their
# transitive libraries and frameworks along. libcurl intentionally comes from
# the macOS SDK through CMake's FindCURL module.
export PKG_CONFIG_PATH="$prefix/lib/pkgconfig:$prefix/share/pkgconfig:${PKG_CONFIG_PATH-}"

build_dir="$repo_root/build/macos-$triplet"
cmake \
	-S "$repo_root" \
	-B "$build_dir" \
	-DCMAKE_BUILD_TYPE=RelWithDebInfo \
	-DAPOPLEXY_USE_STATIC_PKGCONFIG=ON
exec cmake --build "$build_dir"
