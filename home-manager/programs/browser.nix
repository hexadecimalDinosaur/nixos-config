{ ... }:
{
  home = {
    file = {
      ".local/bin/custom-browser" = {
        text = /* sh */ ''
          $''\{BROWSER:-"floorp"} "$@"
        '';
        executable = true;
      };
    };

    sessionVariables = {
      BROWSER = "floorp";
    };
  };

  xdg.desktopEntries.custom-browser = {
    name = "Custom Browser";
    exec = "/home/hexa/.local/bin/custom-browser %u";
    genericName = "Web Browser";
    categories = [ "Application" "Network" "WebBrowser" ];
    mimeType = [ "x-scheme-handler/http" "x-scheme-handler/https" ];
    # noDisplay = true;
    terminal = false;
  };
}
