# `home-manager`

Nix Home Manager configuration, see <https://nix-community.github.io/home-manager>.

## Get and Configure

```sh
# For some packages to run it seems necessary to run for Discord and other apps:
echo 0 | sudo tee /proc/sys/kernel/apparmor_restrict_unprivileged_userns
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
nix-channel --add https://nixos.org/channels/nixos-25.11 nixpkgs
nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz home-manager
nix-channel --list
nix-channel --update
nix-shell '<home-manager>' -A install
git clone git@github.com:mbana/home-manager.git
cd home-manager
ln -vf $(pwd)/home.nix ~/.config/home-manager/home.nix
sudo chsh --shell $(which zsh) $(whoami)
home-manager switch
```

Then start a new shell or optionally just reboot ☺.

### Notes

For commands that require `sudo` run `sudo $(which bpftop)` as `--preserve-env` is not supported by `sudo-rs` at the moment, see: <https://github.com/trifectatechfoundation/sudo-rs/issues/1299> for more information.
