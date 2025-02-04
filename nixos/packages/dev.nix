{ unstable }: { pkgs, ... }:
{
  environment.systemPackages = (with unstable; []) ++ (with pkgs; [
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

  programs.java = {
    enable = true;
    package = pkgs.jdk21;
    binfmt = true;
  };
}
