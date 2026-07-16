#!/usr/bin/env bash

scp ./fstab root@192.168.1.1:/etc/config/fstab
scp ./network root@192.168.1.1:/etc/config/network
scp ./wireless root@192.168.1.1:/etc/config/wireless
scp ./system root@192.168.1.1:/etc/config/system
scp ./dhcp root@192.168.1.1:/etc/config/dhcp

ssh root@192.168.1.1 << EOF
uci commit network
uci commit wireless
uci commit system
uci commit dhcp
uci commit fstab
reboot
EOF

ssh root@192.168.1.1 << EOF
opkg install ripgrep zsh tmux git gdisk strace block-mount kmod-usb-storage block-mount kmod-fs-ext4 e2fsprogs parted kmod-usb-storage usbutils kmod-fs-exfat e2fsprogs kmod-fs-ext4 f2fs-tools gcc iperf3 eza block-mount kmod-fs-ext4 e2fsprogs parted kmod-usb-storage iperf3 diffutils 

# https://openwrt.org/docs/guide-user/services/ssh/openssh_instead_dropbear
opkg update
opkg install openssh-server openssh-sftp-server
sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
mkdir /root/.ssh/
cp /etc/dropbear/authorized_keys /root/.ssh/
uci set dropbear.@dropbear[0].Port=1986
uci commit dropbear
/etc/init.d/dropbear restart
/etc/init.d/sshd enable
/etc/init.d/sshd restart
EOF

scp -r ./root root@192.168.1.1:/

