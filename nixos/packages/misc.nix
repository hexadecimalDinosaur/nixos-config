{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gparted
    fuse-archive
    sshfs
    fuse3
    fuseiso
  ];

  programs = {
    weylus = {
      enable = true;
      openFirewall = true;
    };
  };
}
