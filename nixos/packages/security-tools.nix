{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    tor
    tor-browser
    onionshare-gui
    openldap
    nmap
    macchanger
    # passwords
    keepassxc
    bitwarden-desktop
    libsecret
    # encryption
    (lib.getOutput "dev" gpgme)
    gpg-tui
    picocrypt
    picocrypt-cli
    veracrypt
    age
    age-plugin-yubikey
    age-plugin-fido2-hmac
    gocryptfs
    sirikali
    unstable.cryptomator
    # backups
    rsync
    restic
    restic-integrity
    resticprofile
  ];
}
