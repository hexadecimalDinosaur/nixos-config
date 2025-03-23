{ pkgs, ... }:
{
  environment.systemPackages = (with pkgs; [
    direnv
    gh
    remmina
    rustup
    cling
    zeal
    seer
    pyright
    clang-tools
    nixd
    nix-output-monitor
    python311
    jdk21
    pipx
    git
    clang_14
    cmake
    gnumake
    go
    gdb
    nodejs
  ]);

  programs = {
    java = {
      enable = true;
      package = pkgs.jdk21;
      binfmt = true;
    };
    adb.enable = true;
  };
}
