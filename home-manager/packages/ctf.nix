{ pkgs, ... }:
let

  ghidra-install = (pkgs.unstable.ghidra.withExtensions (
    p: with p; [
      ghidra-golanganalyzerextension
      sleighdevtools
      gnudisassembler
      machinelearning
      findcrypt
      kaiju
  ]));

  rev = with pkgs; [
    # static analysis
    # ===================
    radare2
    cfr
    ghidra-install
    # jadx
    upx
    detect-it-easy
    apktool
    goresym

    # malware analysis
    # ===================
    yara
    # yara-x
  ];
  forensics = with pkgs; [
    # network
    # ===================
    wireshark
    termshark
    tcpdump
    ngrep
    httptoolkit
    vt-cli

    # disks
    # ===================
    secretscanner
    autopsy
    sleuthkit

    # memory
    # ===================
    volatility3
    unstable.volatility2-bin

    # logs
    # ===================
    evtx

    # files/stego
    # ===================
    exiftool
    binwalk
    imhex
    # autopsy
    imagemagick
    stegsolve
    stegseek
    steghide
    zsteg

    # osint
    # ===================
    uncover
    # theharvester
    sherlock
  ];
  web = with pkgs; [
    sqlmap
    burpsuite
    ghauri
  ];
  pwn = with pkgs; [
    pwninit
    pwndbg
    gef
  ];
  redteaming = with pkgs; [
    # scanning - network
    # ===================
    nmap
    nmap-formatter
    nmap-parse
    rustscan
    das
    netdiscover
    massdns
    # masscan
    # p0f

    # scanning - web
    # ===================
    nikto
    zgrab2

    # scanning - linux
    # ===================
    vulnix
    # linux-exploit-suggester
    # data collection
    # responder

    # exploitation
    # ===================
    metasploit
    pacu
    powersploit

    # brute force attacks
    # ===================
    john
    # brutespray
    # thc-hydra
    hashcat
    crunch
    # dirbuster
    # gobuster
  ];
  misc = with pkgs; [
    pwncat
    wordlists
    horcrux
    arsenal
    seclists
  ];
  custom = with pkgs; [
    (callPackage ./../custom-pkgs/binaryninja.nix { })
  ];
in
{
  py3Pkgs = ps: with ps; [
    # forensics
    # ===================
    dissect
    evtx

    # pwn
    # ===================
    pwntools
    ropgadget

    # scanning
    # ===================
    python-nmap
    nmapthon2
    impacket

    # web
    # ===================
    mitmproxy

    # intel
    # ===================
    shodan
    censys

    # analysis
    # ===================
    yara-python
    vt-py

    ( callPackage ./../custom-pkgs/android-unpinner.nix { } )
  ];

  home.packages = builtins.concatLists [
    rev
    web
    pwn
    forensics
    redteaming
    misc
    custom
  ];
}
