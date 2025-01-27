{ config, pkgs, ... }:
let
  unstable = import <nixpkgs-unstable> {};
  unstable-pkgs = with unstable; [
  ];
  stable-pkgs = with pkgs; [
    # security - personal
    tor
    tor-browser
    onionshare-gui
    openldap
    nmap
    macchanger
    keepassxc
    bitwarden-desktop
    # security - rev
    cutter
    radare2
    iaito
    cfr
    upx
    # security - forensics
    sherlock
    volatility3
    wireshark
    exiftool
    termshark
    zsteg
    binwalk
    stegsolve
    stegseek
    steghide
    imhex
    # security - web/pwn
    metasploit
    pwninit
    sqlmap
    pwndbg
    burpsuite
  ];
in
{
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.8"
  ];
  environment.systemPackages = stable-pkgs ++ unstable-pkgs;

  programs.steam = {
    enable = true;
  };
}
