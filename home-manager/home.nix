{
  config,
  pkgs,
  lib,
  ...
}:

let
  pyPkgList = lib.mkOptionType {
    name = "pymods";
    merge = _: defs: map (def: def.value) defs;
  };
in
{
  options.py3Pkgs = lib.mkOption {
    type = pyPkgList;
    default = _: [ ];
  };

  imports = [
    # ./plasma.nix
    ./cli.nix
    ./misc-packages.nix
    ./dev
    ./ssh.nix
    ./ctf.nix
  ];
  
  config = {
    home.username = "hexa";
    home.homeDirectory = "/home/hexa";

    home.stateVersion = "24.11"; # Don't change

    home.file = {
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.packages = with pkgs; [
      (python311.withPackages (ps: builtins.concatMap (f: f ps) config.py3Pkgs))
    ];

    xsession.enable = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
