{
  ...
}:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        IdentityFile = "~/.ssh/id_ed25519";
        ForwardAgent = true;
        StrictHostKeyChecking = "no";
        UserKnownHostsFile = "/dev/null";
        AddKeysToAgent = "yes";
      };
    };
  };
}
