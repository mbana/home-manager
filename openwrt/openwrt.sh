#!/usr/bin/env bash

ssh-copy-id root@OpenWrt

ssh root@OpenWrt << 'EOF'
uci set system.@system[0].timezone='GMT0BST,M3.5.0/1,M10.5.0'
uci set system.@system[0].zonename='Europe/London'
uci commit system

# uci set network.wan.device='br-wan'
uci set network.wan.proto='static'
uci set network.wan.ipaddr='178.255.93.241'
uci set network.wan.netmask='255.255.255.254'
uci set network.wan.gateway='178.255.93.240'
uci set network.wan.dns='1.1.1.1 8.8.8.8 188.215.74.252'
uci commit network

uci set firewall.cfg01e63d.flow_offloading='1'
uci set firewall.cfg01e63d.flow_offloading_hw='1'
uci commit firewall

uci set wireless.default_radio0.ssid='12-Rochford-Close_E6-1QR_2G'
uci set wireless.default_radio1.ssid='12-Rochford-Close_E6-1QR_5G'
uci set wireless.default_radio2.ssid='12-Rochford-Close_E6-1QR_6G'
uci set wireless.default_radio2.key='1234567890'
uci set wireless.ap_mld_1.ssid='12-Rochford-Close_E6-1QR'
uci set wireless.ap_mld_1.key='1234567890'
uci commit wireless
wifi reconf

# service firewall restart
# service network restart
# service system restart
EOF

ssh root@OpenWrt << 'EOF'
opkg update
opkg install ripgrep zsh bash tmux git gdisk strace block-mount kmod-usb-storage block-mount kmod-fs-ext4 e2fsprogs parted kmod-usb-storage usbutils kmod-fs-exfat e2fsprogs kmod-fs-ext4 f2fs-tools iperf3 eza block-mount kmod-fs-ext4 e2fsprogs parted kmod-usb-storage iperf3 diffutils vim-fuller nano-full openssh-server openssh-sftp-server
sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
mkdir -pv /root/.ssh/
chmod 600 /root/.ssh/authorized_keys /etc/dropbear/authorized_keys
cp -v /etc/dropbear/authorized_keys /root/.ssh/
uci set dropbear.@dropbear[0].Port=2222
uci commit dropbear
/etc/init.d/dropbear restart
/etc/init.d/sshd enable
/etc/init.d/sshd restart
EOF

# scp ./config/dhcp root@OpenWrt:/etc/config/dhcp

scp -r ./root/.config root@OpenWrt:/root/.config
scp -r ./root/bin root@OpenWrt:/root/bin
scp -r ./root/.zshrc root@OpenWrt:/root/.zshrc
scp -r ./root/.zsh_history root@OpenWrt:/root/.zsh_history
scp -r ./root/.profile root@OpenWrt:/root/.profile
scp -r ./root/.tmux.conf root@OpenWrt:/root/.tmux.conf

# ssh root@OpenWrt << 'EOF'
# (mv /etc/flowtable.conf /etc/flowtable.conf.bak && nft delete table inet filter) || echo 'nothing to remove for `/etc/flowtable.conf`'
# EOF

ssh -T git@github.com

###

# uci set wireless.default_radio0.background_radar=1
# uci set wireless.default_radio1.background_radar=1
# uci set wireless.default_radio2.background_radar=1
# uci set wireless.default_radio0_mld.background_radar=1
# uci set wireless.default_radio1_mld.background_radar=1
# uci set wireless.default_radio2_mld.background_radar=1
# uci commit wireless
# wifi reload

# uci add dhcp host # =cfg05fe63
# uci set dhcp.@host[-1].name='asus-zenbook-14'
# uci set dhcp.@host[-1].ip='192.168.1.5'
# uci add_list dhcp.@host[-1].mac='C4:62:37:07:C3:43'
# uci commit dhcp
# uci add dhcp host # =cfg05fe63
# uci set dhcp.@host[-1].name='mbana-s26-ultra'
# uci set dhcp.@host[-1].ip='192.168.100'
# uci add_list dhcp.@host[-1].mac='70:4E:E0:0E:39:3F'
# uci commit dhcp

# uci set dhcp.@host[-1].name='Samsung_43"_Neo_QLED'
# uci set dhcp.@host[-1].ip='192.168.1.150'
# uci add_list dhcp.@host[-1].mac='28:E6:A9:1B:18:48'
# uci commit dhcp
