{ unstable }: { config, pkgs, ... }:
{
  environment.systemPackages = (with pkgs; [
    gparted
    fuse-archive
    sshfs
    fuse3
    fuseiso
  ]) ++ (with unstable; [
  ]);
}
