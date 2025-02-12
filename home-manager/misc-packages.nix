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
    eyedropper
    vcv-rack
    fedifetcher
    ricochet-refresh
    osu-lazer
    upscayl
    keybase-gui
    keybase
    kbfs
    yubikey-manager
    mediainfo
    teams-for-linux
    neovide
    discover-overlay
    detect-it-easy
    github-desktop
    wireguard-vanity-address
    zoom-us
    gocryptfs
    fuse-archive
    sshfs
    fuse3
    fuseiso
    sysz
    asciinema
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
