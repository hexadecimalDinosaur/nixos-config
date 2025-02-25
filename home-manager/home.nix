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
  unstable-nixpkgs = import <nixpkgs-unstable> {
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "electron-31.7.7"
      "olm-3.2.16"
      "cinny-4.2.3"
      "cinny-unwrapped-4.2.3"
    ];
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
    ( import ./misc-packages.nix { unstable = unstable-nixpkgs; })
    ( import ./dev { unstable = unstable-nixpkgs; })
    ./ssh.nix
    ( import ./ctf.nix { unstable = unstable-nixpkgs; })
  ];

  config = {
    home.username = "hexa";
    home.homeDirectory = "/home/hexa";

    home.stateVersion = "24.11"; # Don't change

    home.file = {
      ".gnupg/scdaemon.conf" = {
        text = ''
          disable-ccid
        '';
      };
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.packages = with pkgs; [
      (python312.withPackages (ps: builtins.concatMap (f: f ps) config.py3Pkgs))
    ];

    xsession.enable = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
