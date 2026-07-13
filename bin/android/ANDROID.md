# `ANDROID`

From Termux run:

```sh
export PACKAGES="busybox"
yes | termux-setup-storage -y
curl -sL 'https://github.com/mbana/home-manager/raw/refs/heads/main/bin/android/scripts/get-packages.sh' | bash -i -s "${PACKAGES}"
cp -fv "build/${PACKAGES}.zip" "/sdcard/${PACKAGES}.zip"
```

Then from host:

```sh
export PACKAGE="busybox"
adb shell "unzip -d /data/local/tmp/${PACKAGE} -o /sdcard/${PACKAGE}.zip"
adb shell "sh /data/local/tmp/${PACKAGE}/${PACKAGE} --help"
```