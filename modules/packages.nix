{
  pkgs,
  pkgsUnstable,
  ...
}:
{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  # Auto accept Android SDK licenses
  nixpkgs.config.android_sdk.accept_license = true;

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
    micro
    fresh-editor

    coreutils
    findutils
    # binutils # conflicts with `clang` because both provide `ld.gold`.
    moreutils
    plocate
    # gnupg
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
    nixfmt
    nil
    dconf2nix
    # nix-locate
    # nix-index

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
    hgrep
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

    rs-tftpd

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
    # wezterm
    tio
    wl-clipboard
    ghostty

    # Window manager:
    hyprland

    # Android:
    # android-tools
    # androidsdk
    # androidenv.androidPkgs.tools
    # androidenv.androidPkgs.ndk-bundle
    # androidenv.androidPkgs.androidsdk
    # androidenv.androidPkgs.platform-tools

    # Microcontrollers:
  ];
}
