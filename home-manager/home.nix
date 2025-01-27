{ config, pkgs, ... }:

{
  home.username = "hexa";
  home.homeDirectory = "/home/hexa";

  home.stateVersion = "24.11"; # Don't change

  imports = [
    # ./plasma.nix
    ./nvim.nix
    ./cli.nix
    ./packages.nix
    ./nixpkgs_maintenance.nix
    ./python.nix
    ./ssh.nix
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

programs = {
  direnv = {
      enable = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
};

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xsession.enable = true;
  xsession.windowManager.command = ''startplasma-x11'';
}
