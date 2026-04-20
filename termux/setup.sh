#!/usr/bin/env bash

pkg install -y \
	tree zsh atuin starship git nmap neovim vim nano zsh tree which nodejs rust golang lldb gdb llvm clang strace htop fd ripgrep dust eza \
	neovim python3 \*zsh\* sshpass neovim moreutils iproute2 curl wget rclone rsync bat procs lsd delve sqlite valgrind jq netcat-openbsd \
	socat traceroute neofetch screenfetch zip unzip p7zip lz4 zstd gzip bzip2 tmux zellij util-linux build-essential gawk ccache gnupg \
	openssh

cp -vr \
	.config \
	.ssh \
	.zshrc \
	.zsh_history \
	~/