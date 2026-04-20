#!/usr/bin/env bash

pkg install -y \
  tree zsh atuin starship git nmap neovim vim nano zsh tree which nodejs rust golang lldb gdb llvm clang strace htop fd ripgrep dust \
  eza neovim python3 \*zsh\* sshpass neovim moreutils iproute2 curl wget rclone rsync bat procs lsd delve sqlite valgrind jq \
  netcat-openbsd socat traceroute neofetch screenfetch zip unzip p7zip lz4 zstd gzip bzip2 tmux zellij util-linux build-essential \
  gawk ccache gnupg \
  openssh openssl-tool \
  termux-services

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
