# `home-manager`

Nix Home Manager configuration, see <https://nix-community.github.io/home-manager>.

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
# Actually install the Nix package manager now.
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
# restart shell or reboot
exit
```

```sh
nix-channel --add https://nixos.org/channels/nixos-26.05 nixpkgs
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz home-manager
nix-channel --update
nix-channel --list
nix-shell '<home-manager>' -A install
mkdir -pv ~/dev/github/mbana
git clone https://github.com/mbana/home-manager.git ~/dev/github/mbana
cd ~/dev/github/mbana/home-manager
ln -sfv $(pwd)/home.nix ~/.config/home-manager/home.nix
home-manager switch
sudo chsh --shell $(which zsh) $(whoami)
```

Then start a new shell or optionally just reboot ☺. For shell history, do the below:

```sh
atuin login --username 'mbana' --key="${ATUIN_KEY}"
atuin sync
```

## Rust

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
echo '. "${HOME}/.cargo/env"' | tee -a ~/.zprofile | tee -a ~/.profile
```

## Updating

```sh
$ home-manager-switch
```

## Notes

* For commands that require `sudo` run `sudo $(which bpftop)` as `--preserve-env` is not supported by `sudo-rs` at the moment, see: <https://github.com/trifectatechfoundation/sudo-rs/issues/1299> for more information.
* Updating `programs.zsh.shellAliases` requires the shell to be restarted for aliases to be updated.

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