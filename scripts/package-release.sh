#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Stage and archive a clean binary release package.
set -euo pipefail

usage() {
	cat >&2 <<'EOF'
Usage: scripts/package-release.sh --tag TAG --platform PLATFORM --arch ARCH

PLATFORM must be one of: linux, macos, windows
For Linux, set APOPLEXY_PR_HELPER to the native PR helper path when it is not
pr/pr in the repository root.
EOF
	exit 2
}

tag=""
platform=""
arch=""

while [[ $# -gt 0 ]]; do
	case "$1" in
		--tag) tag="${2-}"; shift 2 ;;
		--platform) platform="${2-}"; shift 2 ;;
		--arch) arch="${2-}"; shift 2 ;;
		*) usage ;;
	esac
done

if [[ -z "$tag" || -z "$platform" || -z "$arch" ]]; then
	usage
fi

case "$platform" in
	linux|macos|windows) ;;
	*) usage ;;
esac

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
dist_dir="$repo_root/dist"
package="apoplexy-$tag-$platform-$arch"
stage="$dist_dir/$package"

rm -rf "$stage"
mkdir -p "$stage"

copy_tracked() {
	git -C "$repo_root" archive --format=tar HEAD -- "$@" | tar -xf - -C "$stage"
}

copy_tracked \
	png \
	wav \
	ttf \
	templates \
	docs \
	upack \
	README.md \
	CHANGELOG.md \
	LICENSE

mkdir -p "$stage/pr"
copy_tracked \
	pr/resources.xml \
	pr/pop2.xml \
	pr/gpl.txt \
	pr/credits.txt \
	pr/PR-1.3.1-prerelease.ZIP

case "$platform" in
	linux)
		exe_src="$repo_root/apoplexy"
		exe_name="apoplexy"
		pr_src="${APOPLEXY_PR_HELPER:-$repo_root/pr/pr}"
		pr_dest="$stage/pr/pr"
		archive="$dist_dir/$package.tar.gz"
		;;
	macos)
		exe_src="$repo_root/apoplexy"
		exe_name="apoplexy"
		pr_src="$repo_root/pr/pr-darwin"
		pr_dest="$stage/pr/pr-darwin"
		archive="$dist_dir/$package.tar.gz"
		;;
	windows)
		exe_src="$repo_root/apoplexy.exe"
		exe_name="apoplexy.exe"
		pr_src="$repo_root/pr/pr.exe"
		pr_dest="$stage/pr/pr.exe"
		archive="$dist_dir/$package.zip"
		;;
esac

if [[ ! -f "$exe_src" ]]; then
	printf 'missing executable: %s\n' "$exe_src" >&2
	exit 1
fi
if [[ ! -f "$pr_src" ]]; then
	printf 'missing PR helper: %s\n' "$pr_src" >&2
	exit 1
fi

cp "$exe_src" "$stage/$exe_name"
cp "$pr_src" "$pr_dest"

if [[ "$platform" != "windows" ]]; then
	chmod +x "$stage/$exe_name" "$pr_dest"
fi

if [[ "$platform" == "windows" ]]; then
	if ! command -v ldd >/dev/null 2>&1; then
		printf '%s\n' "ldd was not found; cannot collect Windows runtime DLLs." >&2
		exit 1
	fi
	while IFS= read -r line; do
		for word in $line; do
			case "$word" in
				/ucrt64/bin/*.dll|/mingw64/bin/*.dll)
					cp "$word" "$stage/$(basename "$word")"
					;;
			esac
		done
	done < <(ldd "$exe_src")
fi

mkdir -p \
	"$stage/prince" \
	"$stage/prince2" \
	"$stage/snes" \
	"$stage/levels" \
	"$stage/levels2" \
	"$stage/xml" \
	"$stage/unknown"

(
	cd "$stage"
	./"$exe_name" --version
)

required=(
	"$stage/$exe_name"
	"$stage/png"
	"$stage/wav"
	"$stage/ttf"
	"$stage/templates/snes"
	"$stage/pr/resources.xml"
	"$stage/pr/pop2.xml"
	"$pr_dest"
	"$stage/prince"
	"$stage/prince2"
	"$stage/snes"
)
for item in "${required[@]}"; do
	if [[ ! -e "$item" ]]; then
		printf 'required package entry is missing: %s\n' "$item" >&2
		exit 1
	fi
done

shopt -s nullglob nocaseglob
banned=(
	"$stage"/prince/*.dat
	"$stage"/prince/*.exe
	"$stage"/prince2/*.dat
	"$stage"/prince2/*.exe
	"$stage"/snes/*.smc
	"$stage"/snes/*.sfc
)
for item in "$stage/DOSBox" "$stage/ZSNES"; do
	if [[ -e "$item" ]]; then
		banned+=("$item")
	fi
done
if (( ${#banned[@]} > 0 )); then
	printf 'package contains forbidden bundled game/runtime files:\n' >&2
	printf '  %s\n' "${banned[@]}" >&2
	exit 1
fi
shopt -u nullglob nocaseglob

rm -f "$archive"
case "$platform" in
	linux|macos)
		(
			cd "$dist_dir"
			tar -czf "$archive" "$package"
		)
		;;
	windows)
		if ! command -v zip >/dev/null 2>&1; then
			printf '%s\n' "zip was not found." >&2
			exit 1
		fi
		(
			cd "$dist_dir"
			zip -qr "$archive" "$package"
		)
		;;
esac

printf '%s\n' "$archive"
