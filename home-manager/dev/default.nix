{ unstable }: { pkgs, ... }:
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
    (callPackage ./../custom-pkgs/jetbrains-fleet.nix { })
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
    ./python.nix
    ./nvim.nix
    ( import ./vscode.nix { inherit unstable; } )
    ( import ./nix-dev.nix { inherit unstable; } )
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
    unstable-pkgs
  ];
}
