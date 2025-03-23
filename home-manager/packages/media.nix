{ pkgs, ... }:
{
  home.packages = ( with pkgs; [
    # utilities
    mediainfo
    fluent-reader
    jellyfin-media-player
    jellycli
    musescore
    kdePackages.plasmatube
    kdePackages.kasts
    fedifetcher
    # audio
    vcv-rack
    (buildFHSEnv {
      name = "carla";
      targetPkgs = pkgs: with pkgs; [
        carla
        bankstown-lv2
        lsp-plugins
        decent-sampler
        helm
      ];
      runScript = "carla";
    })
    fluidsynth
    qsynth
  ]) ++ ( with pkgs.unstable; [
    tuba
  ]);
}
