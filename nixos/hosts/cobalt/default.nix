{ pkgs, ... }:
{
  networking.hostName = "cobalt";
  nixpkgs.hostPlatform = "x86_64-linux";

  imports = [
    ./framework13-7040.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    initrd.luks.devices = {
      "luks-5643747d-1a2e-4995-afc6-394eb25fa846" = {  # luks root
        device = "/dev/disk/by-uuid/5643747d-1a2e-4995-afc6-394eb25fa846";
      };
      "luks-b42c9627-a8fc-4849-84cf-a08eac7d183b" = {  # luks swap
        device = "/dev/disk/by-uuid/b42c9627-a8fc-4849-84cf-a08eac7d183b";
      };
    };
  };
  swapDevices = [
    { device = "/dev/disk/by-uuid/27eb06ae-c7af-46c9-9608-b06e7aaa065f"; }
  ];
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/dd783e39-d2b9-4863-b391-d6e389402086";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/3112-FE03";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
      };
    "/tmp" = {
      device = "none";
      fsType = "tmpfs";
      options = [ "size=16G" "mode=777" ];
    };
  };

  system.stateVersion = "24.11"; # do not change
}
