{ config, pkgs, ... }:

let
  pkgsUnstable = import <nixpkgs-unstable> {};
in
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

  # Allow unfree packages
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  # Auto accept Android SDK licenses
  nixpkgs.config.android_sdk.accept_license = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    
    ".config/ccache/ccache.conf".source = ./dotfiles/.config/ccache/ccache.conf;
    ".config/tio/config".source = ./dotfiles/.config/tio/config;
    ".tmux.conf".source = ./dotfiles/.tmux.conf;

    # ".android/" = {
    #   source = ./dotfiles/.android;
    #   recursive = true;
    # };
    # ".wezterm.lua".source = ./dotfiles/.wezterm.lua;
    ".gdbinit".source = ./dotfiles/.gdbinit;
    # Will allow us to install global npm packages without sudo and without polluting the Nix store, and also to have a consistent location for npm global packages across different machines. E.g., `npm install --global @openai/codex` will install it to `~/.npm-global/bin`.
    ".npmrc".source = ./dotfiles/.npmrc;
  
    # # https://github.com/nix-community/home-manager/issues/3090#issuecomment-3341948190
    # ".ssh/id_ed25519.pub".text = ''
    #   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICDGRM+2Fne1yndOyeDWjRwlC2fuyISc3iQSQMRorN61 Mohamed Bana <mohamed.omar.bana@gmail.com>
    # '';
    # ".ssh/authorized_keys".text = ''
    #   ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICDGRM+2Fne1yndOyeDWjRwlC2fuyISc3iQSQMRorN61 Mohamed Bana <mohamed.omar.bana@gmail.com>
    # '';
  };

  # Enable fontconfig to manage fonts.
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
    shfmt
    shellcheck
    asciinema
    curl
    git
    wget
    tmux
    zellij
  
    vim
    neovim

    coreutils
    findutils
    # binutils # conflicts with `clang` because both provide `ld.gold`.
    moreutils
    plocate
    gnupg
    curl
    wget
    watch
    rclone
    rsync
    restic

    # Nix stuff:
    nix-zsh-completions
    statix
    nix-diff
    nix-index
    nixfmt
    # nix-locate

    # Rust tools/stuff:
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
    hexyl
    difftastic
    tealdeer
    duf
    watchexec
    just
    delta
    #Compiling hgrep v0.3.9 (/nix/var/nix/builds/nix-98451-3162612818/source)
    #error: linker `aarch64-linux-gnu-gcc` not found
    #hgrep
    eza

    go
    gopls
    gofumpt
    delve
    golangci-lint

    delve
    nodejs
    # rustc
    # cargo
    # python3

    # Compiler cache
    ccache

    # Kubernetes:
    kubectl
    kubernetes-helm
    kind
    k9s
    stern
    docker-compose
    
    sqlite

    gdb
    valgrind
    # lldb
    # llvm
    # clang
    strace

    jq
    yq

    bottom
    pstree
    tree
    htop
    btop
    # glances
    powertop

    # Networking stuff:
    nmap
    arp-scan
    tcpdump
    socat
    netcat
    traceroute
    tshark
    dnsutils
    unixtools.netstat
    gping
    bandwhich
    mtr
    iftop
    # wireshark
    wireshark-cli
    sshpass
    tailscale

    # System information tools:
    screenfetch

    # Comrpession tools:
    zip
    unzip
    p7zip
    xz
    lz4
    zstd
    gzip
    bzip2
    p7zip

    # eBPF tools:
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

    # Git:
    gh

    # For https://blog.bana.io, otherwise we get the below error:
    # `WARN  Module "github.com/CaiJimmy/hugo-theme-stack/v4" is not compatible with this Hugo version: Min 0.157.0 extended; run "hugo mod graph" for more information.`
    pkgsUnstable.hugo

    # AI tools:
    # claude-code

    # Fonts:
    iosevka
    fira-sans
    cascadia-code

    # Terminal:
    wezterm
    tio
    wl-clipboard

    # Android:
    # android-tools
    # androidsdk
    # androidenv.androidPkgs.tools
    # androidenv.androidPkgs.ndk-bundle
    # androidenv.androidPkgs.androidsdk
    # androidenv.androidPkgs.platform-tools

    # Microcontrollers:
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

  home.sessionVariables = {
    # https://community.nxp.com/t5/i-MX-Processors-Knowledge-Base/Speeding-up-your-recurring-gcc-compilations-with-ccache/ta-p/1127794
    # CROSS_COMPILE = "ccache arm-linux-gnueabihf-";
  };

  # For Claude, Rust, Go and ccache stuff.
  home.sessionPath = [
    "$(find $HOME/bin/ -maxdepth 1 -mindepth 1 -print0 | paste --zero-terminated -d':' -s)"
    "/usr/lib/ccache"
    "/usr/lib/ccache/bin"
    "$HOME/.bin"
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/go/bin"
    "$HOME/.cargo/env"
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
        email = "m@bana.io";
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
      copy = "wl-copy --type 'text/plain;charset=utf-8'";

      sudoroot = "sudo --preserve-env=\"$(env|cut -f1 -d=|tr '\n' ,)\" env ";
      suroot = "sudo --preserve-env=\"$(env|cut -f1 -d=|tr '\n' ,)\" su --preserve-environment";

      ip = "ip --color";

      ls = "ls --color=auto";
      ll = "ls -alh --color=auto -t";

      grep = "grep --color=auto";

      fd = "fd --no-ignore-vcs --hidden --no-ignore --absolute-path --exclude /proc --exclude /sys";

      rg = "rg --no-ignore-vcs --hidden --pcre2 --glob '!{/proc,/sys}'";

      # Navigation
      ".." = "cd ..";
      "...." = "cd ../..";
      "........" = "cd ../../..";

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

    # https://community.nxp.com/t5/i-MX-Processors-Knowledge-Base/Speeding-up-your-recurring-gcc-compilations-with-ccache/ta-p/1127794
    # sessionVariables = {
    #   CROSS_COMPILE = "ccache arm-linux-gnueabihf-";
    #   PATH = "/usr/lib/ccache/bin:$PATH";
    # };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # Sometimes a command times out ... a slow SSD perhaps? I'm not sure.
      # [WARN] - (starship::context): Scanning current directory timed out.
      # [WARN] - (starship::context): You can set scan_timeout in your config to a higher value to allow longer-running scans to keep executing.
      scan_timeout = 6000;
      ## "$schema" = "https://starship.rs/config-schema.json";
      ##
      # add_newline = false;
      # line_break = {
      #   disabled = true;
      # };
      # status = {
      #   disabled = false;
      #   map_symbol = true;
      # };
      # cmd_duration = {
      #   # One minute
      #   min_time = 32000;
      #   show_notifications = true;
      # };
      # Use `${custom.local_ipv4}` instead.
      localip = {
        ssh_only = false;
        format = "@[$localipv4](bold red)";
        disabled = true;
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
      character = {
        success_symbol = "[\\$](bold green)";
        error_symbol = "[\\$](bold red)";
      };
      fill = {
        symbol = " ";
        # style = 'bold green';
      };
      custom.local_ipv4 = {
        command = ''
          ipv4_address=''$(hostname -I | awk '{print ''$1}')
          hostname_hash="$(echo "''$HOSTNAME" | md5sum | awk '{print ''$1}')"
          colors=( 1 2 3 4 5 6 7 )
          # Convert into a positive integer.
          color_index=''$(( 0x''$hostname_hash % ''${#colors[@]} ))
          if [[ ''$color_index -lt 0 ]]; then
            color_index=''$(( -''$color_index ))
          fi
          color=''${colors[''$color_index]}
          printf '\033[38;5;%sm%s\033[0m' "$color" "$ipv4_address"
        '';
        shell = [
          "bash"
          "--noprofile"
          "--norc"
        ];
        when = true;
        unsafe_no_escape = true;
        format = "[$output](bold)";
        # format = "[$output](bold bg:white)";
        # format = "\$all\@[$output](bold)\$directory";
      };
      format = "$all $fill \${custom.local_ipv4} $line_break$character";
      # format = "$all\${custom.local_ipv4} $directory$status$character";
    };
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--disable-up-arrow" ]; # or --disable-ctrl-r
    # settings = {
    #   auto_sync = true;
    #   sync_frequency = "1m";
    # };
  };

  # # Takes a very long time to index.
  # programs.nix-index = {
  #   enable = true;
  #   enableZshIntegration = true;
  # };

  # programs.ssh = {
  #   enable = true;
  #   enableDefaultConfig = false;
  #   # settings = {
  #   #   "*" = {
  #   #     IdentityFile = "~/.ssh/id_ed25519";
  #   #     ForwardAgent = true;
	#   #     StrictHostKeyChecking = "no";
  #   #     UserKnownHostsFile = "/dev/null";
  #   #   };
  #   #   # arm64.oci.bana.io
  #   #   "oci.bana.io" = {
  #   #     HostName = "143.47.251.74";
  #   #     User = "mbana";
  #   #     IdentityFile = "~/.ssh/id_ed25519";
  #   #     ForwardAgent = true;
  #   #   };
  #   # };
  # };
}
