{ lib, pkgs, ... }:
{
  services = {
    tailscale = {
      enable = true;
      useRoutingFeatures = lib.mkDefault "client";
      openFirewall = true;
    };
    openvpn = {
      servers = {
      };
    };
  };

  networking = {
    wireguard.enable = true;

    networkmanager.plugins = with pkgs; [
      networkmanager-openvpn
      networkmanager-openconnect
    ];
  };

  programs.openvpn3.enable = true;

  environment.systemPackages = with pkgs; [
    openvpn3
    openvpn
    openconnect
    wireguard-vanity-address
    wireguard-tools
    protonvpn-cli_2
  ];
}
