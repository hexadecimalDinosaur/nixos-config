{ pkgs, config, ... }:
let
  unstable = import <nixpkgs-unstable> { 
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "olm-3.2.16"
      "electron-31.7.7"
    ];
  };

  unstable-pkgs = with unstable; [
    tuba
    anytype
    nheko
    kdePackages.neochat
    kdePackages.karousel
    feishin
  ];
  stable-pkgs = with pkgs; [
    ropgadget
    eyedropper
    vcv-rack
    fedifetcher
    ricochet-refresh
    cfr
    osu-lazer
    upscayl
    keybase-gui
    keybase
    kbfs
    yubikey-manager
    mediainfo
    upx
    teams-for-linux
    neovide
    discover-overlay
    detect-it-easy
    github-desktop
  ];

in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];
  home.packages = stable-pkgs ++ unstable-pkgs;

  services.keybase.enable = true;
  services.kbfs.enable = true;
}
