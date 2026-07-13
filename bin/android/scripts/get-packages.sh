#!/bin/sh
# From: https://github.com/HunterXProgrammer/Tasker-MdtestV5/blob/main/res/build_dynamic.sh?raw=true
set -x

pkg update -y
pkg upgrade -y

if [ -n "$TERMUX_VERSION" ]; then
	pkg update -y
else
	echo "This script should run on Termux"
	exit 1
fi

yes | pkg install -y p7zip ldd binutils command-not-found tur-repo root-repo x11-repo llvm

mkdir -pv "build" || echo 'already exists'
cd build

PACKAGE_SCRIPT="$(curl -Ls 'https://github.com/mbana/home-manager/blob/main/bin/android/scripts/package.sh?raw=true')"

if [ "$#" -eq 0 ]; then
	set -- busybox
fi

for package in "$@"; do
	IS_VALID="true"
	echo "  Selected package ${package}..."
	if ! command -v "$package"; then
		PACKAGE_INSTALL="$("$PREFIX/libexec/termux/command-not-found" "$package" | grep "pkg install" | head -n 1 | sed "s/.* //g")"
		if [ -n "$PACKAGE_INSTALL" ]; then
			echo ""
			yes | pkg install -y "$PACKAGE_INSTALL"
			IS_VALID="true"
		else
			echo -e "\n  Package ${package} not valid. Skipping..."
			IS_VALID="false"
		fi
	fi
	if [ "$IS_VALID" = "true" ]; then
		rm -rf "${package}.zip" "$package" "${package}.bin" "lib-$package"
		echo -e "\n  Checking package..."
		if ! readelf -d "$(command -v "$package")" 2>/dev/null | grep -q "Dynamic section at"; then
			IS_VALID="false"
		fi
		if [ "$IS_VALID" = "true" ]; then
			echo "$PACKAGE_SCRIPT" >"$package"
			cp -Lv "$(command -v "$package")" "${package}.bin"
			mkdir -pv "lib-$package"
			echo -e "\n  Getting dependencies..."
			for libpath in $(ldd "$(command -v "$package")" | grep -F "/data/data/com.termux/" | sed "s/.* \//\//" | sed "s/ .*//"); do
				cp -Lv "$libpath" "lib-$package"
			done
			echo -e "\n  Zipping package..."
			chmod -v 755 "$package" "${package}.bin"
			chmod -R 755 "lib-$package"
			7z a -tzip -mx=9 -bd -bso0 "${package}.zip" "$package" "${package}.bin" "lib-$package"
		else
			echo -e "\n  Package ${package} not valid. Skipping..."
		fi
		echo -e "\n  Done\n\n-------\n"
	fi
done
