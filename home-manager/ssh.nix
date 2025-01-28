{ ... }:
{
  imports = [
    ./secrets/ssh-hosts.nix
  ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    controlMaster = "auto";
    controlPersist = "5m";
  };
}
