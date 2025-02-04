{ pkgs, config, lib, ... }:
{
  networking.networkmanager = {
    enable = true;
    # wifi.powersave = true;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  services.resolved = {
    enable = true;
    # dnssec = "allow-downgrade";
    # domains = [ "~." ];
    # fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    dnsovertls = "opportunistic";

  };
  networking.networkmanager.dns = "systemd-resolved";
}
