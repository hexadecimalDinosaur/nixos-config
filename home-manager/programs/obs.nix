{ pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-webkitgtk
      obs-transition-table
      obs-source-switcher
      obs-gstreamer
    ];
  };
}
