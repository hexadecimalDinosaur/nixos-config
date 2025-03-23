{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    logseq
    typora
    electrum
    flameshot
    appimage-run
    deepin.deepin-picker
    eyedropper
    libreoffice-qt6-fresh
    qalculate-qt
    # web
    ungoogled-chromium
    floorp
    # file transfer
    nextcloud-client
    filezilla
    wget
    curl
    aria2
    s3fs
    cifs-utils
    rclone
    samba
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
