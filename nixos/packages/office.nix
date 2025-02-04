{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    logseq
    typora
    prusa-slicer
    xournalpp
    electrum
    flameshot
    inkscape
    gimp
    appimage-run
    deepin.deepin-picker
    eyedropper
    floorp
    ungoogled-chromium
    libreoffice-qt6-fresh
    drawio
    qalculate-qt
    # file transfer
    nextcloud-client
    filezilla
    persepolis
    wget
    curl
    aria2
    s3fs
    cifs-utils
    rclone
    samba
    # cad
    blender-hip
    kicad
    # latex
    kile
    texliveFull
    imagemagick
    ghostscript
    # communication
    thunderbird-latest
    discord
    betterdiscordctl
    signal-desktop
    protonmail-bridge-gui
    senpai
  ];

  programs.chromium = {
    enable = true;
    enablePlasmaBrowserIntegration = true;
    extraOpts = {
      "BrowserSignin" = 0;
      "SyncDisabled" = true;
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
        "en-CA"
        "en-US"
      ];
    };
  };
}
