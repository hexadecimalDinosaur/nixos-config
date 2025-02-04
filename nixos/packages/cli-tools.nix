{ unstable }: { config, pkgs, ... }:
{
  programs.zsh.enable = true;
  programs.mtr.enable = true;

  environment.systemPackages = (with unstable; [
  ]) ++ (with pkgs; [
    # nix
    nix-index
    nix-du
    nix-btm
    nix-inspect
    hydra-check
    # sysinfo
    neofetch
    hyfetch
    htop
    btop
    nvtopPackages.full
    owofetch
    fastfetch
    lsb-release
    # shell improvements
    thefuck
    eza
    colorls
    zsh
    oh-my-zsh
    zsh-syntax-highlighting
    fzf
    fzf-zsh
    bat
    tldr
    ripgrep
    zoxide
    tmux
    # file management
    unzip
    unrar
    ranger
    vim
    neovim
    trash-cli
    file
    p7zip
    ripgrep
    # networking
    dig
    whois
    dogedns
    traceroute
    doggo
    trippy
    asn
    lsof
    # misc
    lolcat
    libsecret
    wl-clipboard-x11
    coreutils-full
    wayland-utils
    gnome-randr
    calcurse
  ]);  
}
