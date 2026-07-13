#!/system/bin/sh
set -xv

dir="$(
	cd "$(dirname "$0")"
	pwd
)"
bin_name="$(basename "$0")"
chmod 755 "$0" "$dir/${bin_name}.bin"
chmod -R 755 "$dir/lib-${bin_name}"
export LD_LIBRARY_PATH="$dir/lib-${bin_name}"

if [ "$(getprop ro.build.version.sdk)" -gt 28 ]; then
	if getprop ro.product.cpu.abilist | grep -q "64"; then
		exec /system/bin/linker64 "$dir/${bin_name}.bin" "$@"
	else
		exec /system/bin/linker "$dir/${bin_name}.bin" "$@"
	fi
else
	exec "$dir/${bin_name}.bin" "$@"
fi
