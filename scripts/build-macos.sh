#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Build apoplexy natively on macOS using a project-local vcpkg.
# Resolves SDL2/SDL2_image/SDL2_ttf/libzip from vcpkg.json into
# ./vcpkg_installed/, builds Princed Resources (PR) from the bundled source
# zip into ./pr/pr-darwin (no macOS PR binary ships in the repo), then builds
# apoplexy with CMake.
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

# Build Princed Resources (PR) from the bundled source zip. The repo ships
# pre-built pr/pr (Linux ELF 32-bit) and pr/pr.exe (Windows PE32) but no
# native macOS binary; without one apoplexy cannot import/export PoP1/PoP2
# DOS .DAT files at runtime. Output goes to pr/pr-darwin (gitignored), which
# matches the platform-specific PR_EXECUTABLE define in src/apoplexy.c.
pr_target="$repo_root/pr/pr-darwin"
pr_zip="$repo_root/pr/PR-1.3.1-prerelease.ZIP"
pr_build_dir="$repo_root/.pr-build"
if [[ ! -x "$pr_target" || "$pr_target" -ot "$pr_zip" ]]; then
	rm -rf "$pr_build_dir"
	mkdir -p "$pr_build_dir"
	unzip -q "$pr_zip" -d "$pr_build_dir"
	# PR's Makefile auto-detects Darwin and sets -DMACOS, which selects
	# byte-swapping fread/fwrite shims in disk.c that assume a 2003-era
	# big-endian PowerPC Mac. On Intel/Apple Silicon (little-endian) this
	# corrupts every 32-bit field PR writes to .plv files. Override LINUX
	# to drop -DMACOS so Darwin uses the normal little-endian I/O path.
	make -C "$pr_build_dir/PR-1.3.1-prerelease/src" LINUX=-DNOLINUX all >/dev/null
	cp "$pr_build_dir/PR-1.3.1-prerelease/src/bin/pr" "$pr_target"
	echo "Built $pr_target ($(file -b "$pr_target"))."
fi

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
