{ config, lib, pkgs, modulesPath, ... }:

{
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";
  services.tailscale.openFirewall = true;
  # networking.nameservers = [ "100.100.100.100" ];
  # networking.search = [ "walkah.net.beta.tailscale.net" ];
  
  services.resolved = {
    enable = true;
    # dnssec = "allow-downgrade";
  #   domains = [ "~." ];
  #   fallbackDns = [ "100.100.100.100" "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    dnsovertls = "opportunistic";
  };
  networking.networkmanager.dns = "systemd-resolved";

  networking.wireguard.enable = true;

  programs.openvpn3.enable = true;
  services.openvpn.servers = {
  };

  environment.systemPackages = with pkgs; [
    openvpn3
    openvpn
    networkmanager-openvpn
    networkmanager-openconnect
  ];
}
