# `home-manager`

Nix Home Manager configuration, see <https://nix-community.github.io/home-manager>.

## Get and Configure

```sh
# For some packages to run it seems necessary to run for Discord and other apps:
echo 0 | sudo tee /proc/sys/kernel/apparmor_restrict_unprivileged_userns
```

```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
. ~/.nix-profile/etc/profile.d/nix.sh
echo 'if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi # added by mbana installer' | tee -a ~/.zprofile
nix-channel --add https://nixos.org/channels/nixos-25.11 nixpkgs
nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz home-manager
nix-channel --list
nix-channel --update
nix-shell '<home-manager>' -A install
mkdir -pv ~/dev/github/mbana
cd ~/dev/github/mbana
git clone https://github.com/mbana/home-manager.git
cd home-manager
ln -vf $(pwd)/home.nix ~/.config/home-manager/home.nix
sudo chsh --shell $(which zsh) $(whoami)
home-manager switch
```

Then start a new shell or optionally just reboot ☺.

## Rust

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path
echo '. "${HOME}/.cargo/env"' | tee -a ~/.zprofile
echo '. "${HOME}/.cargo/env"' | tee -a ~/.profile
```

### Notes

* For commands that require `sudo` run `sudo $(which bpftop)` as `--preserve-env` is not supported by `sudo-rs` at the moment, see: <https://github.com/trifectatechfoundation/sudo-rs/issues/1299> for more information.
* Updating `programs.zsh.shellAliases` requires the shell to be restarted for aliases to be updated.
