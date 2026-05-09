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
  # home.stateVersion = "24.05"; # Please read the comment before changing.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # Allow unfree packages
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # Will allow us to install global npm packages without sudo and without polluting the Nix store, and also to have a consistent location for npm global packages across different machines. E.g., `npm install --global @openai/codex` will install it to `~/.npm-global/bin`.
    ".npmrc".text = ''
      prefix=~/.npm-global
    '';

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
  
    # https://github.com/nix-community/home-manager/issues/3090#issuecomment-3341948190
  };

  # Enable fontconfig to manage fonts.
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    iosevka
    fira-sans

    curl
    git
    wget
    tmux
    zellij
  
    vim
    neovim

    coreutils
    moreutils
    tree

    rclone
    rsync

    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search

    # nix-locate
    nix-zsh-completions

    # Rust tools/stuff
    # https://zaiste.net/posts/shell-commands-rust/
    bat
    fd
    procs
    sd
    dust
    starship
    ripgrep
    tokei
    hyperfine
    tealdeer
    bandwhich
    grex
    zoxide
    delta
    lsd
    atuin

    go
    delve
    nodejs
    # rustc
    # cargo
    # python3

    # Kubernetes.
    kubectl
    kubernetes-helm
    k9s
    
    sqlite

    gdb
    valgrind
    lldb
    llvm
    clang
    strace

    jq

    bottom
    htop
    btop
    # glances

    # Networking stuff
    nmap
    tcpdump
    # wireshark
    socat
    netcat
    traceroute
    tshark

    tailscale

    # System information tools
    screenfetch
    neofetch

    # Comrpession tools
    zip
    unzip
    p7zip
    xz
    lz4
    zstd
    gzip
    bzip2

    # eBPF tools
    bpf-linker
    bpftrace
    bpftools
    bpfmon
    bpftop
    bpftune
    bpftrace
    libbpf
    bcc
    pwru

    # Git
    gh

    # For https://blog.bana.io
    hugo

    # AI tools
    claude-code
  ];

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
  # home.sessionVariables = {
  #   EDITOR = "code --wait --new-window";
  #   VISUAL = "code --wait --new-window";
  # };

  # For Claude, Rust and Go stuff.
  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/env"
    "$HOME/go/bin"
    "$HOME/.npm-global/bin"
  ];

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
      # copy = "xclip -selection clipboard";
      # paste = "xclip -o -selection clipboard";

      ip = "ip --color";

      ls = "ls --color=auto";
      ll = "ls -alh --color=auto";
      grep = "grep --color=auto";

      # fd = "fd --hidden --follow --exclude /proc --exclude /sys --exclude $(go env GOPATH)";
      # rg = "rg --follow --glob '!{/proc,/sys,$(go env GOPATH),**/.git/*,**/*.rs}'";
      # rg = "rg --follow --glob '!{/proc,/sys,$(go env GOPATH),.git,*.rs}'";
      # fd = "fd --hidden --ignore-case --follow --no-ignore-parent --no-ignore --unrestricted --show-errors --absolute-path";
      fd = "fd --absolute-path --exclude /proc --exclude /sys --exclude $(go env GOPATH) --exclude '**/.git/*'";

      # rg = "rg --hidden --follow --glob-case-insensitive --ignore-case --no-ignore --no-ignore-dot --no-ignore-exclude --no-ignore-global --no-ignore-parent --no-ignore-vcs --no-require-git --text --pcre2 --pretty";
      # rg = "rg --hidden --follow --glob-case-insensitive --ignore-case --no-ignore --pcre2 --pretty";
      rg = "rg --pcre2 --glob '!{/proc,/sys,$(go env GOPATH),**/.git/*}'";

      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";

      # Misc.
      mkdir = "mkdir -pv";
      cp = "cp -v";
      mv = "mv -v";
      rm = "rm -vi";

      # Home Manager
      home-manager-switch = "cd ~/dev/github/mbana/home-manager && git pull && ln -sfv $(pwd)/home.nix ~/.config/home-manager/home.nix && home-manager switch";

      # Dev aliases
      dev-dir = "cd ~/dev/github/mbana/";
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
    # initContent = ''
    #   source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    # '';
    # sessionVariables = {
    #   EDITOR = "code --wait --new-window";
    # };
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

  # # Takes a very long time to index.
  # programs.nix-index = {
  #   enable = true;
  #   enableZshIntegration = true;
  # };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      # amd64.nebius.bana.io
      "nebius.bana.io" = {
        hostname = "66.201.4.153";
        user = "mbana";
        identityFile = "~/.ssh/id_ed25519";
        forwardAgent = true;
        # serverAliveInterval = 60;
      };
      # arm64.oci.bana.io
      "oci.bana.io" = {
        hostname = "143.47.251.74";
        user = "mbana";
        identityFile = "~/.ssh/id_ed25519";
        forwardAgent = true;
      };
      # amd64.scw.bana.io
      "scw.bana.io" = {
        # hostname = "2001:bc8:710:f64c:dc00:ff:fec8:5b5";
        hostname = "d614f050-2738-46f6-a4d7-68a4fea9633d.pub.instances.scw.cloud";
        user = "mbana";
        identityFile = "~/.ssh/id_ed25519";
        forwardAgent = true;
      };

      # Local stuff on same network
      "dock-sabrent" = {
        hostname = "10.0.0.2";
        user = "mbana";
        identityFile = "~/.ssh/id_ed25519";
      };
      "dock-kiwee" = {
        hostname = "10.0.0.3";
        user = "mbana";
        identityFile = "~/.ssh/id_ed25519";
      };
      "mbana-zenbook-14" = {
        hostname = "10.0.0.4";
        user = "mbana";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
