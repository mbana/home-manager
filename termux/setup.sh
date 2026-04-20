#!/usr/bin/env bash

function enable_and_start_service_sshd() {
  # local service="$1"
  # termux-services enable "$service"
  # termux-services start "$service"

	sv-enable sshd
	cp -v \
    ./sshd_config \
    /data/data/com.termux/files/usr/etc/ssh/sshd_config
	sv down sshd || echo "sshd is not running, skipping restart"
	sv up sshd
  echo "sshd service enabled and started"
}

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

cp -vr \
  .config \
  .ssh \
  .zshrc \
  .zprofile \
  .zsh_history \
  ~/

# https://github.com/Automattic/node-canvas/issues/2385
# mkdir ~/.gyp && echo "{'variables':{'android_ndk_path':''}}" > ~/.gyp/include.gypi

pkg install -y tur-repo
pkg install -y code-server

pkg update
pkg upgrade -y

ln -svf /data/data/com.termux/files/usr/bin/code-server ~/.bin/vscode-server
ln -svf /data/data/com.termux/files/usr/bin/code-server ~/.local/bin/vscode-server
ln -svf /data/data/com.termux/files/usr/bin/code-server ~/bin/vscode-server

enable_and_start_service_sshd