# `home-manager`

Nix Home Manager configuration, see <https://nix-community.github.io/home-manager>.

## Get and Configure

Initial setup:

```sh
echo -e "\n$(whoami) ALL=(ALL) NOPASSWD:ALL\n" | sudo tee -a /etc/sudoers.d/99-$(whoami)
```

Misc. setup:

```sh
echo '# Disable IPv6' | sudo tee -a /etc/sysctl.d/100-ipv6.conf
echo 'net.ipv6.conf.all.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.d/100-ipv6.conf
echo 'net.ipv6.conf.default.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.d/100-ipv6.conf
echo 'net.ipv6.conf.lo.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.d/100-ipv6.conf

echo 'fs.inotify.max_user_watches = 524288' | sudo tee -a /etc/sysctl.d/100-fs.conf
echo 'kernel.dmesg_restrict = 0' | sudo tee -a /etc/sysctl.d/100-kernel.conf
echo 'kernel.sysrq = 1' | sudo tee -a /etc/sysctl.d/100-kernel.conf

# Initially it was `2147483647`.
echo 'fs.inotify.max_user_watches = 524288' | sudo tee -a /etc/sysctl.d/100-fs.conf
# echo 'fs.inotify.max_user_instances = 2147483647' | sudo tee -a /etc/sysctl.d/100-fs.conf

sudo apt autoremove --purge -y snapd gnome-software-plugin-snap
sudo rm -rf /var/cache/snapd/
# rm -frv ~/snap
# sudo apt-mark hold snapd
```

Setup the `groups` and `sudo` configuration:

```sh
echo kvm libvirt wireshark docker | xargs -n 1 sudo groupadd
sudo usermod --append --groups kvm,libvirt,wireshark,docker "$(whoami)"
```

```sh
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
cd ~/dev/github/mbana
git clone https://github.com/mbana/home-manager.git
cd ~/dev/github/mbana/home-manager
ln -sfv $(pwd)/home.nix ~/.config/home-manager/home.nix
home-manager switch
sudo chsh --shell $(which zsh) $(whoami)
atuin login --username 'mbana' --key="${ATUIN_KEY}"
atuin sync
```

Then start a new shell or optionally just reboot ☺.

## Rust

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
echo '. "${HOME}/.cargo/env"' | tee -a ~/.zprofile | tee -a ~/.profile
```

The last line above is probably not needed because the below is present in [`home.nix`](./home.nix):

```nix
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/env"
    "$HOME/go/bin"
  ];
```

## Updating

```sh
cd ~/dev/github/mbana/home-manager && git pull && ln -sfv $(pwd)/home.nix ~/.config/home-manager/home.nix && home-manager switch
```

## Notes

* For commands that require `sudo` run `sudo $(which bpftop)` as `--preserve-env` is not supported by `sudo-rs` at the moment, see: <https://github.com/trifectatechfoundation/sudo-rs/issues/1299> for more information.
* Updating `programs.zsh.shellAliases` requires the shell to be restarted for aliases to be updated.
