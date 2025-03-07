{ ... }:
{
  imports = [
    ./packages
    ./programs
    ./dev
  ];

  home = rec {
    username = "hexa";
    homeDirectory = "/home/${username}";

    stateVersion = "24.11"; # Don't change

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  xsession.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
