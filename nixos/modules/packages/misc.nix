{ pkgs, unstable, ... }:
{
  environment.systemPackages = (with pkgs; [
    gparted
    fuse-archive
    sshfs
    fuse3
    fuseiso
  ]) ++ (with unstable; [
  ]);

  programs = {
    weylus = {
      enable = true;
      openFirewall = true;
    };
  };
}
