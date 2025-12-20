{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mbana";
  home.homeDirectory = "/home/mbana";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # Allow unfree packages
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  # Enable XDG base directory support or rather programs to show in application menu.
  # targets.genericLinux.enable = true;
  xdg = {
    enable = true;
  };

  # Enable fontconfig to manage fonts, some bueaityful fonts ...
  fonts.fontconfig.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    (pkgs.writeShellScriptBin "ptyxis.sh" ''
      #!/usr/bin/env sh
      /usr/bin/ptyxis --new-window --standalone
    '')

    pkgs.iosevka
    pkgs.fira-sans

    pkgs.curl
    pkgs.git
    pkgs.wget
    pkgs.tmux
    pkgs.zellij
    pkgs.gdb
    pkgs.valgrind
    pkgs.vim

    pkgs.neovim
    pkgs.vscode

    pkgs.coreutils
    pkgs.moreutils
    pkgs.tree

    pkgs.rclone
    pkgs.rsync

    pkgs.zsh
    pkgs.zsh-autosuggestions
    pkgs.zsh-syntax-highlighting
    pkgs.zsh-history-substring-search

    # pkgs.nix-locate

    pkgs.starship
    pkgs.atuin

    pkgs.fd
    pkgs.ripgrep

    pkgs.jq

    pkgs.go
    pkgs.nodejs
    # pkgs.rustup

    pkgs.htop
    pkgs.btop
    pkgs.glances

    pkgs.nmap
    pkgs.tcpdump
    # pkgs.wireshark
    pkgs.socat
    pkgs.netcat
    pkgs.traceroute
    pkgs.tshark

    pkgs.screenfetch
    pkgs.neofetch

    pkgs.zip
    pkgs.unzip
    pkgs.p7zip
    pkgs.xz
    pkgs.lz4
    pkgs.zstd
    pkgs.gzip
    pkgs.bzip2

    # eBPF tools
    pkgs.bpf-linker
    pkgs.bpftrace
    pkgs.bpftools
    pkgs.bpfmon
    pkgs.bpftop
    pkgs.bpftune
    pkgs.bpftrace
    pkgs.libbpf
    pkgs.bcc
    pkgs.pwru

    # Does not appear in applications menu, no time to debug ...
    # pkgs.ghostty
    # Very slow compared to Flatpak version for some reason. No time to debug ...
    # pkgs.discord
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".gdbinit".text = ''
      set debuginfod enabled on

      set confirm off
      set verbose on

      set print pretty on
      set print object on
      set print static-members on

      set history save on
      set history size unlimited
      set history filename ~/.gdb_history

      set pagination off
      set startup-quietly on
    '';
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
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    EDITOR = "code --wait --new-window";
    VISUAL = "code --wait --new-window";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git ={
    enable = true;
    lfs.enable = true;
    ignores = [
      # Ignore these folders
      ".ignore"
      ".ignore/"
      ".tmp"
      ".tmp/"
    ];
    # Sign all commits using ssh key
    signing = {
      format = "ssh";
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "Mohamed Bana";
        email = "mohamed.omar.bana@gmail.com";
      };
      init = {
        defaultBranch = "main";
      };
      color = {
        ui = "true";
        advice = "true";
        status = "always";
      };
      core = {
        ignorecase = "false";
        hideDotFiles = "false";
        editor = "code --wait --new-window";
      };
      commit = {
        verbose = true;
      };
      # Use SSH instead of HTTPS for GitHub and GitLab
      url = {
        "git@github.com:" = {
          insteadOf = [
            "https://github.com/"
          ];
        };
      };
      url = {
        "git@gitlab.com:" = {
          insteadOf = [
            "https://gitlab.com/"
          ];
        };
      };
      alias = {
        d = "diff";
        dc = "diff --cached";
        s = "status";
        ll = "log -n1";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    shellAliases = {
      copy = "xclip -selection clipboard";
      paste = "xclip -o -selection clipboard";
      ip = "ip --color";
      fd = "fd --hidden --follow";
      # fd = "fd --hidden --follow --exclude /proc --exclude /sys --exclude $(go env GOPATH)";
      # rg = "rg --follow --glob '!{/proc,/sys,$(go env GOPATH),**/.git/*,**/*.rs}'";
      # rg = "rg --follow --glob '!{/proc,/sys,$(go env GOPATH),.git,*.rs}'";
      rg = "rg --follow";
      ll = "ls -alh --color=auto";
    };
    history = {
      append = true;
      expireDuplicatesFirst = true;
      findNoDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      saveNoDups = true;

      path = "${config.programs.zsh.dotDir}/.zsh_history";
      save = 1000000000;

      share = false;
      size = 1000000000;
    };
    initContent = ''
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    '';
    sessionVariables = {
      EDITOR = "code --wait --new-window";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      ## "$schema" = "https://starship.rs/config-schema.json";
      ##
      ##add_newline = true;
      ##line_break = {
      ##  disabled = true;
      ##}
      localip = {
        ssh_only = false;
        format = "@[$localipv4](bold red) ";
        disabled = false;
      };
      username = {
        disabled = false;
        show_always = true;
      };
      hostname = {
        disabled = false;
        ssh_only = false;
      };
      directory = {
        truncate_to_repo = false;
        truncation_length = 0;
      };
    };
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--disable-up-arrow" ]; # or --disable-ctrl-r
  };

  programs.vscode = {
    enable = true;
  };

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
  };

  # programs.command-not-found = {
  #   enable = true;
  # };

  # Takes a very long time to index.
  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };
}
