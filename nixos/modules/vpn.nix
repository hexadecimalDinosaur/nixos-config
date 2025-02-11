{ pkgs, ... }:

{
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";
  services.tailscale.openFirewall = true;

  networking.wireguard.enable = true;

  programs.openvpn3.enable = true;
  services.openvpn.servers = {
  };

  environment.systemPackages = with pkgs; [
    openvpn3
    openvpn
    networkmanager-openvpn
    networkmanager-openconnect
    ktailctl
    wireguard-vanity-address
    wireguard-tools
    protonvpn-cli_2
  ];
}
