#!/usr/bin/env bash

function enable_and_start_service_sshd() {
  sv-enable sshd
  cp -v \
    ./sshd_config \
    /data/data/com.termux/files/usr/etc/ssh/sshd_config
  sv down sshd || echo "sshd is not running, skipping restart"
  sv up sshd
  echo "sshd service enabled and started"
}

function install_all_packages() {
  # pkg list-all | awk '{print $1}' | tail -n +2 | xargs -I{} pkg install -y {}
  pkg list-all 2>/dev/null | awk '{print $1}' | tail -n +2500 | cut -d'/' -f1 | grep -E -v 'dropbear|hash-slinger|pyunbound|polyml' | xargs -I{} sh -c "pkg install -y {} || echo 'Failed to install {}'"
}

pkg update
pkg upgrade -y

pkg install -y \
  tree zsh atuin starship git nmap neovim vim nano zsh tree which nodejs rust golang lldb gdb llvm clang strace htop fd ripgrep dust \
  eza neovim python3 \*zsh\* sshpass neovim moreutils iproute2 curl wget rclone rsync bat procs lsd delve sqlite valgrind jq \
  netcat-openbsd socat traceroute neofetch screenfetch \
  zip unzip p7zip lz4 zstd gzip bzip2 \
  tmux zellij util-linux build-essential \
  gawk ccache gnupg \
  openssh openssl-tool \
  termux-services x11-repo termux-tools \
  android-tools \
  build-essential \
  binutils \
  pkg-config \
  python3 \
  nodejs-lts \
  getconf \
  git-lfs \
  bash-completion man

pkg update
pkg upgrade -y

npm config set python python3
node -v

cp -vr --interactive \
  .config \
  .ssh \
  .zshrc \
  .zprofile \
  .zsh_history \
  ~/

cp -vr --interactive \
  .termux \
  ~/.termux/

# https://github.com/Automattic/node-canvas/issues/2385
# mkdir ~/.gyp && echo "{'variables':{'android_ndk_path':''}}" > ~/.gyp/include.gypi

# # TODO: Remove as it is not working.
# pkg install -y tur-repo
# pkg install -y code-server

# pkg update
# pkg upgrade -y

# ln -svf /data/data/com.termux/files/usr/bin/code-server ~/.bin/vscode-server
# ln -svf /data/data/com.termux/files/usr/bin/code-server ~/.local/bin/vscode-server
# ln -svf /data/data/com.termux/files/usr/bin/code-server ~/bin/vscode-server

# https://github.com/termux/glibc-packages
# pkg install glibc-repo -y

enable_and_start_service_sshd
