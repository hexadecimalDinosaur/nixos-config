{ pkgs, ... }:
{
  imports = [
    ./media.nix
    ./ctf.nix
  ];

  home.packages = (with pkgs; [
    eyedropper
    vcv-rack
    fedifetcher
    ricochet-refresh
    osu-lazer
    upscayl
    keybase-gui
    keybase
    kbfs
    discover-overlay
    detect-it-easy
    asciinema
    bitwarden-cli
    moonlight-qt
    apkeep
    qtscrcpy
    desktop-file-utils
  ]) ++ (with pkgs.unstable; [
    anytype
    nheko
    cinny-desktop
    kdePackages.karousel
    zoom-us
    teams-for-linux
    halloy
    floorp
    vivaldi
  ]);

  services.keybase.enable = true;
  services.kbfs.enable = true;
}
