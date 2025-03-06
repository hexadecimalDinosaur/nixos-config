{ ... }:
{
  imports = [
    ./hardware                    # drivers, audio, external devices
    ./modules/nix.nix             # nix and nixpkgs settings
    ./modules/networking.nix      # network config
    ./modules/bootloader.nix      # bootloader (GRUB)
    ./modules/locale.nix          # timezone, dictionaries, i18n, input methods
    ./modules/packages            # packages
    ./modules/fonts.nix           # fonts
    ./modules/vpn.nix             # vpn configuration (openvpn, openconnect, tailscale)
    ./security                    # firewall, auditd, etc.
    ./modules/virtualization.nix  # VMs, docker
    ./modules/ld.nix              # nix-ld
  ];


  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    displayManager = {
      sddm.enable = true;
    };
    desktopManager = {
      plasma6.enable = true;
    };
  };


  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
