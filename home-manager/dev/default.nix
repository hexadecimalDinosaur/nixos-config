{ pkgs, ... }:
let
  unstable = import <nixpkgs-unstable> { };

  build-tools = with pkgs; [
    clang_14
    cmake
    gnumake
    go
  ];
  runtimes = with pkgs; [
    jdk21
    nodejs
  ];
  lang-servers = with pkgs; [
    vscode-langservers-extracted
    pyright
    nixd
    jdt-language-server
    bash-language-server
    yaml-language-server
    clang-tools # clangd for c++/c
    marksman
  ];
  debuggers = with pkgs; [
    gdb
    seer
    pwndbg
  ];
  nixpkgs-tools = with unstable; [
    nixfmt-rfc-style
    nixpkgs-review
    hydra-check
  ];
  ides = with pkgs; [
    arduino-ide
    jetbrains.pycharm-professional
    jetbrains.dataspell
    # jetbrains.idea-ultimate
    # jetbrains.clion

  ];
  tools = with pkgs; [
    insomnia
    beekeeper-studio
    gh
    zeal
    git
    gitkraken
    direnv
    lazygit
    lazysql
    lazycli
    infisical
  ];
  unstable-pkgs = with unstable; [
    flarectl
    linode-cli
    awscli2
  ];
in
{
  imports = [
    ./python-packages.nix
    ./vscode.nix
    ./nvim.nix
    ./git.nix
  ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };

  home.packages = builtins.concatLists [
    runtimes
    build-tools
    lang-servers
    debuggers
    nixpkgs-tools
    ides
    tools
    unstable-pkgs
  ];
}
