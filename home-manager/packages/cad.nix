{ pkgs, ... }:
{
  home.packages = with pkgs; [
    blender-hip
    kicad
    prusa-slicer
    # cura
    openscad
    openscad-lsp
  ];
}
