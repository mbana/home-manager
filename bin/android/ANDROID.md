# `ANDROID`

From Termux run:

```sh
export PACKAGES="busybox fd ripgrep"
yes | termux-setup-storage -y >/dev/null
curl -sL 'https://github.com/mbana/home-manager/blob/main/bin/android/build-dynamic.sh?raw=true' | bash -i -s -x -v  "${PACKAGES}" 2>/dev/null
cp -fv "build/${PACKAGES}.zip" "/sdcard/${PACKAGES}.zip"
```

Then from host:

```sh
adb shell 'PACKAGE=busybox; unzip -d /data/local/tmp/${PACKAGE} -o /sdcard/${PACKAGE}.zip'
adb shell "sh /data/local/tmp/busybox/busybox" --help
```