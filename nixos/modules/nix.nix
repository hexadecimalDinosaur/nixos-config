{ pkgs, ... }:
{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "@wheel" ];
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    optimise = {
      automatic = true;
      dates = [ "Sun 04:15" ];
      # persistent = false;  # waiting for this to release in 25.05
    };
  };

  programs.nh = {
    enable = true;
    flake = "/etc/nixos";

    clean = {
      enable = true;
      dates = "Sun 04:15";
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };

  environment.systemPackages = with pkgs; [
    nix-index
    nix-du
    nix-btm
    nix-inspect
    hydra-check
    nix-melt
    nvd
  ];
}
