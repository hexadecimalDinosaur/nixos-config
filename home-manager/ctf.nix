{ unstable }: { pkgs, config, libs, ... }:
let
  unstable-pkgs = with unstable; [
    volatility2-bin
  ];

  ghidra-install = (unstable.ghidra.withExtensions (
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

    # disks
    # ===================
    secretscanner
    autopsy
    sleuthkit

    # memory
    # ===================
    volatility3

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
    metasploit
    pacu

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
    (callPackage ./custom-pkgs/binaryninja.nix { })
  ];
in
{
  py3Pkgs = ps: with ps; [
    # forensics
    # ===================
    dissect
    evtx
    # pwn
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
  ];

  home.packages = builtins.concatLists [
    unstable-pkgs
    rev
    web
    pwn
    forensics
    redteaming
    misc
    custom
  ];
}
