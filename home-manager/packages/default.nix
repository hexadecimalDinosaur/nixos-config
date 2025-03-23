{ pkgs, ... }:
{
  imports = [
    ./media.nix
    ./ctf.nix
    ./cad.nix
    ./graphics.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "olm-3.2.16"
      "electron-31.7.7"
      "cinny-4.2.3"
      "cinny-unwrapped-4.2.3"
    ];
  };

  home.packages = (with pkgs; [
    eyedropper
    ricochet-refresh
    osu-lazer
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
    toolong
  ]) ++ (with pkgs.unstable; [
    nheko
    cinny-desktop
    zoom-us
    teams-for-linux
    halloy
    floorp
    vivaldi
  ]);

  services.keybase.enable = true;
  services.kbfs.enable = true;
}
