{ pkgs, ... }:
{
  imports = [
    ./firewall.nix
  ];

  programs = {
    ssh.startAgent = true;
    gnupg.agent = {
      enable = true;
    };
  };

  security = {
    auditd.enable = true;
    audit.enable = true;

    polkit.enable = true;

    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
  };


  environment.systemPackages = with pkgs; [
    tpm2-tools
    tpm2-pkcs11
  ];
}
