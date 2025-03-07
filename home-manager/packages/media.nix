{ pkgs, ... }:
{
  home.packages = ( with pkgs; [
    ( calibre.overrideAttrs (finalAttrs: prevAttrs: {
      preFixup = (
        builtins.replaceStrings
          [
            ''
              wrapProgram $program \
            ''
          ]
          [
            ''
              wrapProgram $program \
                --prefix LD_LIBRARY_PATH : ${pkgs.openssl.out}/lib \
            ''
          ]
          prevAttrs.preFixup
      );
    }))
    mediainfo
    fluent-reader
  ]) ++ ( with pkgs.unstable; [
    tuba
    ncspot
  ]);

  programs = {
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
          background = "#1a1b26";
          primary = "#9aa5ce";
          secondary = "#414868";
          title = "#9ece6a";
          playing = "#7aa2f7";
          playing_selected = "#bb9af7";
          playing_bg = "#24283b";
          highlight = "#c0caf5";
          highlight_bg = "#24283b";
          error = "#414868";
          error_bg = "#f7768e";
          statusbar = "#ff9e64";
          statusbar_progress = "#7aa2f7";
          statusbar_bg = "#1a1b26";
          cmdline = "#c0caf5";
          cmdline_bg = "#24283b";
          search_match = "#f7768e";
        };
      };
    };
  };
}
