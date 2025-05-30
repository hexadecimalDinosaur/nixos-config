{ pkgs, ... }:
{
  programs = {
    zsh.enable = true;
    mtr.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # sysinfo
    neofetch
    hyfetch
    htop
    btop
    usbtop
    iftop
    nvtopPackages.full
    owofetch
    fastfetch
    lsb-release
    sysz
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
    mangl
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
    speedtest-cli
    # misc
    lolcat
    libsecret
    wl-clipboard-x11
    coreutils-full
    wayland-utils
    gnome-randr
    calcurse
    font-config-info
    jq
  ];
}
