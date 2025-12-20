# `home-manager`

Nix Home Manager configuration, see <https://nix-community.github.io/home-manager>.

## Get and Configure

```sh
# For some packages to run it seems necessary to run:
echo 0 | sudo tee /proc/sys/kernel/apparmor_restrict_unprivileged_userns
echo
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
echo
nix-channel --add https://nixos.org/channels/nixos-25.11 nixpkgs
nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz home-manager
nix-channel --list
nix-channel --update
echo
nix-shell '<home-manager>' -A install
echo
mkdir -pv ~/.config/
cd ~/.config/
echo
git clone git@github.com:mbana/home-manager.git
cd ~/.config/home-manager
echo
home-manager switch
```

Then start a new shell or optionally just reboot ☺.

### Notes

For commands that require `sudo` run `sudo $(which bpftop)` as `--preserve-env` is not supported by `sudo-rs` at the moment, see: <https://github.com/trifectatechfoundation/sudo-rs/issues/1299> for more information.
