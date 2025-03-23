{ pkgs, ... }:
{
  home.packages = with pkgs; [
    inkscape
    gimp
    xournalpp
    kdePackages.kdenlive
    upscayl
  ];
}
