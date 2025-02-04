{ unstable }: { pkgs, ... }:
{
  environment.systemPackages = (with pkgs; [
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
    yt-dlp
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
    # libraries
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
  ]) ++ (with unstable; [
    ncspot
  ]);
}
