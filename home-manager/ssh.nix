{ pkgs, ... }:
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
    extraConfig = ''
      PKCS11Provider ${pkgs.tpm2-pkcs11}/lib/libtpm2_pkcs11.so
    '';
  };
}
