{ pkgs, ... }:
{
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  xdg.portal = {
    # enable = true;
    xdgOpenUsePortal = true;
    # extraPortals = [
    #   pkgs.kdePackages.xdg-desktop-portal-kde
    # ];
    # configPackages = [
    #   pkgs.kdePackages.plasma-workspace
    # ];
  };
}
