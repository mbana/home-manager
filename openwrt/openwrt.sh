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
uci commit
/etc/init.d/network restart
/etc/init.d/wireless restart
/etc/init.d/system restart
EOF

ssh root@192.168.1.1 << EOF
opkg update
opkg install ripgrep zsh tmux git gdisk strace block-mount kmod-usb-storage block-mount kmod-fs-ext4 e2fsprogs parted kmod-usb-storage usbutils kmod-fs-exfat e2fsprogs kmod-fs-ext4 f2fs-tools gcc iperf3 eza block-mount kmod-fs-ext4 e2fsprogs parted kmod-usb-storage iperf3 diffutils 

# https://openwrt.org/docs/guide-user/services/ssh/openssh_instead_dropbear
opkg update
opkg install openssh-server openssh-sftp-server
sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
mkdir /root/.ssh/
cp /etc/dropbear/authorized_keys /root/.ssh/
uci set dropbear.@dropbear[0].Port=2222
uci commit dropbear
/etc/init.d/dropbear restart
/etc/init.d/sshd enable
/etc/init.d/sshd restart
EOF

echo "Waiting for OpenWrt to restart..."
sleep 8

scp -r ./root/.config root@192.168.1.1:/root/.config
scp -r ./root/bin root@192.168.1.1:/root/bin
scp -r ./root/.zshrc root@192.168.1.1:/root/.zshrc
scp -r ./root/.zsh_history root@192.168.1.1:/root/.zsh_history
ssh root@192.168.1.1 'chmod 600 /root'

uci set wireless.default_radio0.background_radar=1
uci set wireless.default_radio1.background_radar=1
uci set wireless.default_radio2.background_radar=1
uci set wireless.default_radio0_mld.background_radar=1
uci set wireless.default_radio1_mld.background_radar=1
uci set wireless.default_radio2_mld.background_radar=1
uci commit wireless
wifi reload

uci set dhcp.@host[-1].name='asus-zenbook-14'
uci set dhcp.@host[-1].ip='192.168.1.5'
uci add_list dhcp.@host[-1].mac='C4:62:37:07:C3:43'
uci commit
uci set dhcp.@host[-1].name='mbana-s26-ultra'
uci set dhcp.@host[-1].ip='192.168.100'
uci add_list dhcp.@host[-1].mac='70:4E:E0:0E:39:3F'

uci set dhcp.@host[-1].name='Samsung_43"_Neo_QLED'
uci set dhcp.@host[-1].ip='192.168.1.150'
uci add_list dhcp.@host[-1].mac='28:E6:A9:1B:18:48'
uci commit
