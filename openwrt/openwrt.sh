#!/usr/bin/env bash

scp ./config/fstab root@192.168.1.1:/etc/config/fstab
scp ./config/network root@192.168.1.1:/etc/config/network
scp ./config/wireless root@192.168.1.1:/etc/config/wireless
scp ./config/system root@192.168.1.1:/etc/config/system
scp ./config/dhcp root@192.168.1.1:/etc/config/dhcp

ssh root@192.168.1.1 << EOF
uci commit network
uci commit wireless
uci commit system
uci commit dhcp
uci commit fstab
uci commit
/etc/init.d/network restart
/etc/init.d/wireless restart
/etc/init.d/system restart
/etc/init.d/dhcp restart
/etc/init.d/fstab restart
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

echo "Waiting for OpenWrt to restart..."
sleep 8

scp -r ./root root@192.168.1.1:/

# # Disable IPv6
# uci set network.lan.ipv6='0'
# uci set network.lan.ip6assign='0'
# uci commit network
# /etc/init.d/network restart
