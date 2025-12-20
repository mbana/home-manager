# `home-manager`

Nix Home Manager configuration, see https://nix-community.github.io/home-manager.

## Get and Configure

```sh
mkdir -pv ~/.config/
cd ~/.config/
git clone git@github.com:mbana/home-manager.git
cd ~/.config/home-manager
home-manager switch
```

### Notes

For commands that require `sudo` run `sudo $(which bpftop)` as `--preserve-env` is not supported by `sudo-rs` at the moment, see: <https://github.com/trifectatechfoundation/sudo-rs/issues/1299> for more information.
