{ config, pkgs, ... }:
let
  unstable = import <nixpkgs-unstable> {};
  unstable-pkgs = with unstable; [
    ncspot
    cryptomator
  ];
  stable-pkgs = with pkgs; [
    # office
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
    # media
    feh
    vlc
    ffmpeg-full
    spotify
    calibre
    rssguard
    audacity
    musescore
    cmus
    playerctl
    mpv
    obs-studio
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-webkitgtk
        obs-transition-table
        obs-source-switcher
        obs-gstreamer
      ];
    })
    yt-dlp
    # games
    steam
    steam-run-free
    steamcmd
    steam-tui
    steam-rom-manager
    itch
    rogue
    lutris
    lime3ds
    desmume
    dolphin-emu
    # file transfer
    nextcloud-client
    filezilla
    persepolis
    wget
    curl
    aria2
    s3fs
    cifs-utils
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
    discord
    betterdiscordctl
    signal-desktop
    protonmail-bridge-gui
    senpai
    # sysadmin
    restic
    gparted
    distrobox
    distrobox-tui
    nix-index
    nix-du
    nix-btm
    nix-inspect
    # cli utils - sysinfo
    neofetch
    hyfetch
    htop
    btop
    nvtopPackages.full
    owofetch
    fastfetch
    lsb-release
    # cli tools - networking
    dig
    whois
    dogedns
    traceroute
    doggo
    trippy
    asn
    lsof
    # cli tools - shell improvements
    eza
    thefuck
    colorls
    zsh
    oh-my-zsh
    zsh-syntax-highlighting
    fzf
    fzf-zsh
    bat
    tldr
    ripgrep
    zoxide
    tmux
    # cli tools - file management
    unzip
    unrar
    ranger
    vim
    neovim
    trash-cli
    file
    p7zip
    ripgrep
    # cli utils - misc
    lolcat
    libsecret
    wl-clipboard-x11
    coreutils-full
    # libraries
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
  ];
in
{
  imports = [
    ./plasma.nix
    ./dev.nix
    ./security.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.8"
    "olm-3.2.16"
    "electron-27.3.11"
    "cinny-4.2.2"
    "dotnet-sdk-wrapped-7.0.410"
    "dotnet-sdk-7.0.410"
  ];
  environment.systemPackages = stable-pkgs ++ unstable-pkgs;

  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    extest.enable = true;
    remotePlay.openFirewall = true;
  };
}
