# `home-manager`

Nix Home Manager configuration, see <https://nix-community.github.io/home-manager>.

## Install Nix and setup Home Manager

```sh
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
# restart shell, reboot, logout an log back in or start a new shell.
exit
```

```sh
nix-channel --add https://nixos.org/channels/nixos-26.05 nixpkgs
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
mkdir -pv ~/dev/github/mbana
git clone https://github.com/mbana/home-manager.git ~/dev/github/mbana/home-manager
cd ~/dev/github/mbana/home-manager
ln -sfv $(pwd)/home.nix ~/.config/home-manager/home.nix
home-manager switch
sudo chsh --shell $(which zsh) $(whoami)
```

Then start a new shell or optionally just reboot ☺. For shell history, do the below:

## Rust

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y
echo '. "${HOME}/.cargo/env"' | tee -a ~/.zprofile
```

## History

Replace `ATUIN_KEY` below with an actual valid key:

```sh
atuin login --username 'mbana' --key="${ATUIN_KEY}"
atuin sync
```
