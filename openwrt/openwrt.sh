#!/usr/bin/env bash

scp ./config/system root@OpenWrt:/etc/config/system
scp ./config/network root@OpenWrt:/etc/config/network
scp ./config/wireless root@OpenWrt:/etc/config/wireless

ssh root@OpenWrt << 'EOF'
PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] ' >> ~/.bashrc

uci set network.wan.device='br-wan'
uci set network.wan.proto='static'
uci set network.wan.ipaddr='178.255.93.241'
uci set network.wan.netmask='255.255.255.254'
uci set network.wan.gateway='178.255.93.240'
uci set network.wan.dns='1.1.1.1 8.8.8.8'
mv /etc/flowtable.conf /etc/flowtable.conf.bak # Permanent fix (survives reboot)
nft delete table inet filter # Apply immediately without reboot
uci commit

uci commit network
uci commit wireless
uci commit system

mv /etc/flowtable.conf /etc/flowtable.conf.bak # Permanent fix (survives reboot)
nft delete table inet filter # Apply immediately without reboot
uci commit

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

ssh-copy-id root@OpenWrt
echo "Waiting for OpenWrt to restart..."
sleep 8

scp -r ./root/.config root@OpenWrt:/root/.config
scp -r ./root/bin root@OpenWrt:/root/bin
scp -r ./root/.zshrc root@OpenWrt:/root/.zshrc
scp -r ./root/.zsh_history root@OpenWrt:/root/.zsh_history

ssh root@OpenWrt << 'EOF'
wifi reconf
service network restart
service system restart
EOF

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
# uci commit
# uci add dhcp host # =cfg05fe63
# uci set dhcp.@host[-1].name='mbana-s26-ultra'
# uci set dhcp.@host[-1].ip='192.168.100'
# uci add_list dhcp.@host[-1].mac='70:4E:E0:0E:39:3F'
# uci commit

# uci set dhcp.@host[-1].name='Samsung_43"_Neo_QLED'
# uci set dhcp.@host[-1].ip='192.168.1.150'
# uci add_list dhcp.@host[-1].mac='28:E6:A9:1B:18:48'
# uci commit
