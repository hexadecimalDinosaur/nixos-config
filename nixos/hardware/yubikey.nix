{ pkgs, config, lib, ... }:
{
  services = {
    udev = {
      packages = with pkgs; [
        yubikey-personalization
      ];
    };

    pcscd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pcscliteWithPolkit
    yubioath-flutter
    yubikey-manager
    yubikey-personalization-gui
  ];

  programs = {
    yubikey-touch-detector = {
      enable = true;
      libnotify = true;
    };
  };

  hardware.gpgSmartcards.enable = true;
}
