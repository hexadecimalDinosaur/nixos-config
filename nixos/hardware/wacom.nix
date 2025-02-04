{ pkgs, config, lib, ... }:
{
  services = {
    udev = {
      packages = with pkgs; [
        yubikey-personalization
      ];
    };

    pcscd.enable = true;

    xserver = {
      wacom.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    xf86_input_wacom
    libwacom
    (lib.mkIf config.services.desktopManager.plasma6.enable kdePackages.wacomtablet)
  ];

  programs = {
  };
}
