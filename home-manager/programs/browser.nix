{ pkgs, config, ... }:
let
  custom-browser = pkgs.writeShellScriptBin "custom-browser" ''
    $''\{BROWSER:-"${config.home.sessionVariables.BROWSER}"} "$@"
  '';
in
{
  home = {
    sessionVariables = {
        BROWSER = "floorp";
    };
    packages = [
      custom-browser
    ];
  };

  xdg.desktopEntries.custom-browser = {
    name = "Custom Browser";
    exec = "${custom-browser.out}/bin/custom-browser %u";
    genericName = "Web Browser";
    categories = [ "Application" "Network" "WebBrowser" ];
    mimeType = [ "x-scheme-handler/http" "x-scheme-handler/https" ];
    # noDisplay = true;
    terminal = false;
  };
}
