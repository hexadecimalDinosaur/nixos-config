{ config, pkgs, ... }:
let
  nixpkgs-unstable = import <nixpkgs-unstable> {
    config.allowUnfree = true;
  };
in
{
  imports = [
    ( import ./cli-tools.nix { unstable = nixpkgs-unstable; })
    ( import ./dev.nix { unstable = nixpkgs-unstable; })
    ./games.nix
    ( import ./media.nix { unstable = nixpkgs-unstable; })
    ( import ./misc.nix { unstable = nixpkgs-unstable; })
    ./office.nix
    ./plasma.nix
    ( import ./security-tools.nix { unstable = nixpkgs-unstable; })
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
    "electron-27.3.11"
    "cinny-4.2.2"
    "python-2.7.18.8"
    "dotnet-sdk-wrapped-7.0.410"
    "dotnet-sdk-7.0.410"
  ];
}
