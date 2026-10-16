{
  config,
  ...
}:
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/ghostty/config.ghostty".source = ./dotfiles/.config/ghostty/config.ghostty;
    ".config/ccache/ccache.conf".source = ./dotfiles/.config/ccache/ccache.conf;
    ".config/tio/config".source = ./dotfiles/.config/tio/config;
    ".tmux.conf".source = ./dotfiles/.tmux.conf;
    ".gdbinit".source = ./dotfiles/.gdbinit;
    # Will allow us to install global npm packages without sudo and without polluting the Nix store, and also to have a consistent location for npm global packages across different machines. E.g., `npm install --global @openai/codex` will install it to `~/.npm-global/bin`.
    ".npmrc".source = ./dotfiles/.npmrc;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mbana/etc/profile.d/hm-session-vars.sh
  home.sessionVariables = {
    IDF_PATH = "${config.home.homeDirectory}/.espressif/master/esp-idf";
    EDITOR = "code --wait --new-window";
    VISUAL = "code --wait --new-window";
  };

  # For Claude, Rust, Go and ccache stuff.
  # find bin/ -maxdepth 1 -mindepth 1 -printf '"${config.home.homeDirectory}/%p/"\n' | paste --zero-terminated -d':' -s
  # find bin/ -maxdepth 1 -mindepth 1 -printf '"${config.home.homeDirectory}/%p/"\n'
  home.sessionPath = [
    "${config.home.homeDirectory}/bin/tftp-now-linux"
    "${config.home.homeDirectory}/bin/ptyxis"
    "${config.home.homeDirectory}/bin/fresh-editor-x86_64-unknown-linux-gnu"
    "${config.home.homeDirectory}/bin/pktstat-bpf_0.18.0_linux_amd64.pkg"
    "${config.home.homeDirectory}/bin/ookla-speedtest-1.2.0-linux-x86_64"
  ]
  ++ [
    "$\{IDF_PATH\}/tools"
    "/usr/lib/ccache"
    "/usr/lib/ccache/bin"
    "$HOME/bin"
    "$HOME/.bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/.npm-global/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # # Takes a very long time to index.
  # programs.nix-index = {
  #   enable = true;
  #   enableZshIntegration = true;
  # };
  # # Command-not-found handler to suggest nix way of installing stuff.
  # programs.nix-index-database.comma.enable = true;
  programs.command-not-found.enable = true;

  # https://wiki.nixos.org/wiki/Home_Manager#Usage_on_non-NixOS_Linux
  targets.genericLinux.enable = true;
  # Enable fontconfig to manage fonts.
  fonts.fontconfig.enable = true;

  imports = [
    ./packages.nix
    ./shell.nix
    ./ssh.nix
    ./git.nix
    ./dconf.nix
    ./packages.nix
  ];
}
