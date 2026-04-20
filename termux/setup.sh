#!/usr/bin/env bash

pkg update
pkg upgrade -y

pkg install -y \
  tree zsh atuin starship git nmap neovim vim nano zsh tree which nodejs rust golang lldb gdb llvm clang strace htop fd ripgrep dust \
  eza neovim python3 \*zsh\* sshpass neovim moreutils iproute2 curl wget rclone rsync bat procs lsd delve sqlite valgrind jq \
  netcat-openbsd socat traceroute neofetch screenfetch zip unzip p7zip lz4 zstd gzip bzip2 tmux zellij util-linux build-essential \
  gawk ccache gnupg \
  openssh openssl-tool \
  termux-services \
  android-tools \
  build-essential \
  binutils \
  pkg-config \
  python3 \
  nodejs-lts

pkg update
pkg upgrade -y

npm config set python python3
node -v

pkg install -y tur-repo
pkg install -y code-server

pkg update
pkg upgrade -y

cp -vr \
  .config \
  .ssh \
  .zshrc \
  .zsh_history \
  ~/

sv-enable sshd
cp -v \
  ./sshd_config \
  /data/data/com.termux/files/usr/etc/ssh/sshd_config
sv down sshd || echo "sshd is not running, skipping restart"
sv up sshd

# https://github.com/Automattic/node-canvas/issues/2385
# mkdir ~/.gyp && echo "{'variables':{'android_ndk_path':''}}" > ~/.gyp/include.gypi
