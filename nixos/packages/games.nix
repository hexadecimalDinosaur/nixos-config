{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    steamcmd
    steam-tui
    steam-rom-manager
    itch
    rogue
    lutris
    lime3ds
    desmume
    dolphin-emu
  ];

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    extest.enable = true;
    remotePlay.openFirewall = true;
  };
}
