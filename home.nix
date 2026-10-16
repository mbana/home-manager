{
  inputs,
  ...
}:
{
  home.username = "mbana";
  home.homeDirectory = "/home/mbana";
  home.stateVersion = "26.11";
  home.backupFileExtension = "bak.${toString inputs.self.lastModifiedDate}";
  home.file = {
    "bin/ptyxis".source = ./bin/linux/ptyxis.sh;
    ".config/ghostty/config.ghostty".source = ./dotfiles/.config/ghostty/config.ghostty;
    ".config/ccache/ccache.conf".source = ./dotfiles/.config/ccache/ccache.conf;
    ".config/tio/config".source = ./dotfiles/.config/tio/config;
    ".tmux.conf".source = ./dotfiles/.tmux.conf;
    ".gdbinit".source = ./dotfiles/.gdbinit;
    # Will allow us to install global npm packages without sudo and without polluting the Nix store, and also to have a consistent location for npm global packages across different machines. E.g., `npm install --global @openai/codex` will install it to `~/.npm-global/bin`.
    ".npmrc".source = ./dotfiles/.npmrc;
  };
  home.sessionVariables = {
    IDF_PATH = "${builtins.getEnv "HOME"}/.espressif/master/esp-idf";
    EDITOR = "code --wait --new-window";
    VISUAL = "code --wait --new-window";
  };
  home.sessionPath = [
    "$\{IDF_PATH\}/tools"
    "/usr/lib/ccache"
    "/usr/lib/ccache/bin"
    "$HOME/bin"
    "$HOME/.bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/.npm-global/bin"
  ];
  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
  xdg.enable = true;
  fonts.fontconfig.enable = true;
  imports = [
    ./modules/packages.nix
    ./modules/shell.nix
    ./modules/ssh.nix
    ./modules/git.nix
    ./modules/dconf.nix
  ];
}
