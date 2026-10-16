{
  ...
}:
{
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

      path = "${builtins.getEnv "HOME"}/.zsh_history";
      save = 1000000000;

      # TODO: Change this back to `false`.
      share = true;
      size = 1000000000;
    };
    initContent = ''
      . "''${HOME}/.cargo/env" || echo "ERROR: failed to source ''${HOME}/.cargo/env"
      . "''${HOME}/export-esp.sh" || echo "ERROR: failed to source ''${HOME}/export-esp.sh"
    '';
    # initContent = ''
    #   source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
    # '';
    sessionVariables = {
      EDITOR = "code --wait --new-window";
      VISUAL = "code --wait --new-window";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
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
    settings = {
      auto_sync = true;
      sync_frequency = "1m";
    };
  };

  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installVimSyntax = true;
  };
}
