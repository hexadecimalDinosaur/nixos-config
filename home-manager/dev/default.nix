{ pkgs, ... }:
let
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
  ides = with pkgs; [
    arduino-ide
    jetbrains.pycharm-professional
    jetbrains.dataspell
    # jetbrains.datagrip
    jetbrains.idea-ultimate
    jetbrains.clion
    android-studio
    (callPackage ./../custom-pkgs/jetbrains-fleet.nix { })
  ];
  tools = with pkgs; [
    insomnia
    beekeeper-studio
    gh
    zeal
    git
    gitkraken
    github-desktop
    direnv
    lazygit
    lazysql
    lazycli
    infisical
    android-tools
    unstable.flarectl
    unstable.linode-cli
    unstable.awscli2
    unstable.azure-cli
    unstable.backblaze-b2
    unstable.powershell
  ];
in
{
  imports = [
    ./python.nix
    ./nix-dev.nix
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
    ides
    tools
  ];
}
