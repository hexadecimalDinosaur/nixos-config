{ pkgs, ... }:
{
  services = {
    udev = {
      extraRules = ''
        KERNEL=="ttyACM[0-9]*", SUBSYSTEM=="tty", SUBSYSTEMS=="usb", ATTRS{idVendor}=="1546", ATTRS{idProduct}=="01a7", SYMLINK+="gps-tty"
      '';
    };

    gpsd = {
      enable = true;
      readonly = false;
      devices = [
        "/dev/gps-tty"
      ];
    };
  };

  systemd.services.gpsd.enable = false;

  environment.systemPackages = with pkgs; [
    gpsd
  ];
}
