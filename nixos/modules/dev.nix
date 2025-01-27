{ config, pkgs, ... }:
let
  unstable = import <nixpkgs-unstable> {};
  unstable-pkgs = with unstable; [
  ];
  stable-pkgs = with pkgs; [
    direnv
    gh
    remmina
    rustup
    docker-compose
    beekeeper-studio
    insomnia
    cling
    vscode
    arduino-ide
      # jetbrains.pycharm-professional
      # jetbrains.idea-ultimate
      # jetbrains.dataspell
      # jetbrains.clion
    zeal
    seer
    pyright
    clang-tools
    nixd
    python311
    python311Packages.pip
    jdk21
    pipx
    git
    clang_14
    cmake
    gnumake
    go
    gdb
    gitkraken
    nodejs
  ];
in
{
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.8"
    "dotnet-sdk-wrapped-7.0.410"
    "dotnet-sdk-7.0.410"
  ];
  environment.systemPackages = stable-pkgs ++ unstable-pkgs;

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
    binfmt = true;
  };
}
