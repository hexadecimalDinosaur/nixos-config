{ pkgs, config, lib, ... }:
{
  boot.initrd.availableKernelModules = [ "thunderbolt" ];

  services = {
    hardware.bolt = {
      enable = true;
    };

    udev = {
      packages = with pkgs; [
        displaylink
      ];
    };
  };

  environment.systemPackages =  with pkgs; [
    pkgs.displaylink
    (lib.mkIf config.services.desktopManager.plasma6.enable kdePackages.plasma-thunderbolt)
  ];
}
