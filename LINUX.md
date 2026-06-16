# `LINUX`

Commands to run before/after setting Home Manager.

## Get and Configure

```sh
# Setup sudoers
echo -e "\n$(whoami) ALL=(ALL) NOPASSWD:ALL\n" | sudo tee -a /etc/sudoers.d/99-$(whoami)
# Allow running `dmesg` as normal user, i.e., not root.
echo 'kernel.dmesg_restrict = 0' | sudo tee -a /etc/sysctl.d/100-kernel.conf
echo 'kernel.sysrq = 1' | sudo tee -a /etc/sysctl.d/100-kernel.conf
# For VSCode.
echo 'fs.inotify.max_user_watches = 524288' | sudo tee -a /etc/sysctl.d/100-fs.conf
# Disable IPv6
echo 'net.ipv6.conf.all.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.d/100-ipv6.conf
echo 'net.ipv6.conf.default.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.d/100-ipv6.conf
echo 'net.ipv6.conf.lo.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.d/100-ipv6.conf
# Refresh settings
sudo sysctl --system
# Setup the `groups` and add user to the group.
echo kvm libvirt wireshark docker | xargs -n 1 sudo groupadd
sudo usermod --append --groups kvm,libvirt,wireshark,docker "$(whoami)"
```

## Post Install / Quality of Life

```sh
# Remove/Disable unattended upgrades.
sudo systemctl disable --now unattended-upgrades
sudo apt remove -y unattended-upgrades

# Remove/Disable Ubuntu SystemD Daily.Timers, see https://gist.github.com/posilva/1cefb5bf1eeccf9382920e5d57a4b3fe.

sudo systemctl kill --kill-who=all apt-daily.service
sudo systemctl kill --kill-who=all apt-daily-upgrade.service

sudo systemctl stop apt-daily.timer
sudo systemctl disable apt-daily.timer
sudo systemctl stop apt-daily.service
sudo systemctl disable apt-daily.service

sudo systemctl stop apt-daily-upgrade.timer
sudo systemctl disable apt-daily-upgrade.timer
sudo systemctl stop apt-daily-upgrade.service
sudo systemctl disable apt-daily-upgrade.service
sudo systemctl daemon-reload
sudo systemctl reset-failed

sudo rm -v /etc/systemd/system/timers.target.wants/apt-daily.timer
sudo rm -v /etc/systemd/system/timers.target.wants/apt-daily-upgrade.timer

sudo mv -v /usr/lib/apt/apt.systemd.daily /usr/lib/apt/apt.systemd.daily.DISABLED
sudo mv -v /lib/systemd/system/apt-daily.service /lib/systemd/system/apt-daily.service.DISABLED
sudo mv -v /lib/systemd/system/apt-daily.timer /lib/systemd/system/apt-daily.timer.DISABLED
sudo mv -v /lib/systemd/system/apt-daily-upgrade.service /lib/systemd/system/apt-daily-upgrade.service.DISABLED
sudo mv -v /lib/systemd/system/apt-daily-upgrade.timer /lib/systemd/system/apt-daily-upgrade.timer.DISABLED

# Remove snap/snapd
sudo apt autoremove --purge -y snapd gnome-software-plugin-snap
sudo rm -rfv /var/cache/snapd/
rm -frv ~/snap
# sudo apt-mark hold snapd
```

## Notes

* For commands that require `sudo` run `sudo $(which bpftop)` as `--preserve-env` is not supported by `sudo-rs` at the moment, which Ubuntu will soon switch to, see: <https://github.com/trifectatechfoundation/sudo-rs/issues/1299> for more information.
