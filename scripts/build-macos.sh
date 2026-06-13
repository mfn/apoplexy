#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Build apoplexy natively on macOS using a project-local vcpkg.
# Resolves SDL2/SDL2_image/SDL2_ttf/libzip from vcpkg.json into
# ./vcpkg_installed/, builds Princed Resources (PR) from the bundled source
# zip into ./pr/pr-darwin (no macOS PR binary ships in the repo), then runs
# the existing src/Makefile unchanged.
#
# Honors $VCPKG_ROOT if set (opt-out for users with a shared vcpkg);
# otherwise auto-clones vcpkg into ./.vcpkg/ on first run.
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"

if [[ -n "${VCPKG_ROOT-}" && -x "$VCPKG_ROOT/vcpkg" ]]; then
	vcpkg_root="$VCPKG_ROOT"
else
	vcpkg_root="$repo_root/.vcpkg"
	if [[ ! -x "$vcpkg_root/vcpkg" ]]; then
		git clone --depth=1 https://github.com/microsoft/vcpkg "$vcpkg_root"
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

# vcpkg's x64-osx triplet produces static libs (.a); SDL2_image/SDL2_ttf/libzip
# carry transitive deps (libSDL2 itself, libpng, zlib, freetype, framework -lWl,...)
# that the existing src/Makefile's hardcoded link line does not list. Generate a
# sdl2-config shim that emits the full static link line via pkg-config; the
# Makefile's literal "-lSDL2_ttf -lSDL2_image -lzip" become harmless duplicates.
shim_dir="$repo_root/.vcpkg-shim"
mkdir -p "$shim_dir"
cat > "$shim_dir/sdl2-config" <<'SHIM'
#!/usr/bin/env bash
set -euo pipefail
out=()
for arg; do
	case "$arg" in
		--cflags)  out+=( $(pkg-config --cflags sdl2) ) ;;
		--libs)    out+=( $(pkg-config --static --libs SDL2_image SDL2_ttf libzip sdl2) ) ;;
		--version) out+=( $(pkg-config --modversion sdl2) ) ;;
	esac
done
echo "${out[@]}"
SHIM
chmod +x "$shim_dir/sdl2-config"

# Apple Clang honors CPATH/LIBRARY_PATH like implicit -I/-L, so the existing
# src/Makefile picks up vcpkg headers and libs without modification. The shim
# sdl2-config above takes precedence on PATH for transitive deps.
export PATH="$shim_dir:$PATH"
export PKG_CONFIG_PATH="$prefix/lib/pkgconfig:${PKG_CONFIG_PATH-}"
export CPATH="$prefix/include:$prefix/include/SDL2:${CPATH-}"
export LIBRARY_PATH="$prefix/lib:${LIBRARY_PATH-}"

exec make -C "$repo_root/src"
