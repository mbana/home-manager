#!/bin/bash
# Ensure these settings are set in VS Code `settings.json`:
#
#   "terminal.explorerKind": "both",
#   "terminal.external.linuxExec": "ptyxis.sh"
#   // "terminal.external.linuxExec": "/usr/bin/ptyxis",
#   // "terminal.external.linuxExec": "x-terminal-emulator",

# #!/usr/bin/env sh
# /usr/bin/ptyxis --new-window --standalone

# https://github.com/microsoft/vscode/issues/179958
# GTK_PATH="" x-terminal-emulator $@

# ❯ ps -p $$ -F    
# UID          PID    PPID  C    SZ   RSS PSR STIME TTY          TIME CMD
# mbana      60280   15198  0 59020  7360   8 09:34 pts/1    00:00:00 /home/mbana/.nix-profile/bin/zsh

# mbana in asus-zenbook-14 in @192.168.1.158 ~ 
# ❯       ps -p 15198 -F
# UID          PID    PPID  C    SZ   RSS PSR STIME TTY          TIME CMD
# mbana      15198   15190  0 94816  8120   7 Jul28 ?        00:00:01 /usr/libexec/ptyxis-agent --socket-fd=3 --rlimit-nofile=1024

# mbana in asus-zenbook-14 in @192.168.1.158 ~ 
# ❯       ps -p 15190 -F
# UID          PID    PPID  C    SZ   RSS PSR STIME TTY          TIME CMD
# mbana      15190    4309  0 644004 195312 0 Jul28 ?        00:01:02 /usr/bin/ptyxis --gapplication-service

/usr/bin/ptyxis --new-window "$@"
