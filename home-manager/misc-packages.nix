{ unstable }: { pkgs, config, ... }:
let
  unstable-pkgs = with unstable; [
    tuba
    anytype
    nheko
    cinny-desktop
    kdePackages.karousel
    zoom-us
    teams-for-linux
    halloy
    kdocker
    floorp
    vivaldi
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
    mediainfo
    discover-overlay
    detect-it-easy
    github-desktop
    asciinema
    bitwarden-cli
    fluent-reader
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
