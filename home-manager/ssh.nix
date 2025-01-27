{ ... }:
{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    controlMaster = "auto";
    controlPersist = "5m";

    matchBlocks = {
      # REDACTED
    };
  };
}
