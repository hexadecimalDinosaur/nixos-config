{ config, pkgs, lib, ... }:
{
  imports = [
    ./system.nix                  # attributes unique to the system (users, hostname, etc.)
    ./hardware                    # drivers, audio, external devices
    ./modules/networking.nix      # network config
    ./modules/bootloader.nix      # bootloader (GRUB)
    ./modules/locale.nix          # timezone, dictionaries, i18n, input methods
    ./packages                    # packages
    ./modules/fonts.nix           # fonts
    ./modules/vpn.nix             # vpn configuration (openvpn, openconnect, tailscale)
    ./security                    # firewall, auditd, etc.
    ./modules/virtualization.nix  # VMs, docker
    ./modules/ld.nix              # nix-ld

    (let
      module = fetchTarball {
        name = "source";
        url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";
        sha256 = "sha256-DN5/166jhiiAW0Uw6nueXaGTueVxhfZISAkoxasmz/g=";
      };
      lixSrc = fetchTarball {
        name = "source";
        url = "https://git.lix.systems/lix-project/lix/archive/2.91.1.tar.gz";
        sha256 = "sha256-hiGtfzxFkDc9TSYsb96Whg0vnqBVV7CUxyscZNhed0U=";
      };
      in import "${module}/module.nix" { lix = lixSrc; }
    )
  ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

    gvfs.enable = true;
    # envfs.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  fileSystems."/tmp" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=16G" "mode=777" ];
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
