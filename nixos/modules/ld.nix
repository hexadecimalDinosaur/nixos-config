{ pkgs, ... }:
{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib
      stdenv.cc.cc
    ];
  };

  environment.systemPackages = with pkgs; [
    nix-alien
  ];
}
