{ pkgs, ... }:
{
  programs = {
    spicetify = {
      enable = true;
      enabledExtensions = with pkgs.spicePkgs.extensions; [
      ];
      theme = pkgs.spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };

    ncspot = {
      enable = true;
      package = pkgs.unstable.ncspot;
      settings = {
        shuffle = true;
        repeat = "playlist";
        gaplist = true;
        bitrate = 320;
        backend = "pulseaudio";
        use_nerdfont = true;
        theme = {
          background = "#1e1e2e";
          primary = "#cdd6f4";
          secondary = "#a6adc8";
          title = "#cba6f7";
          playing = "#cba6f7";
          playing_selected = "#f5c2e7";
          playing_bg = "#313244";
          highlight = "#f5c2e7";
          highlight_bg = "#45475a";
          error = "#f38ba8";
          error_bg = "#6c7086";
          statusbar = "#b4befe";
          statusbar_progress = "#cba6f7";
          statusbar_bg = "#1e1e2e";
          cmdline_bg = "#a6adc8";
          cmdline = "#11111b";
          search_match = "#fab387";
        };
      };
    };
  };

  home.packages = with pkgs; [
    unstable.psst
  ];
}
