{ pkgs, ... }:
{
  networking.hostName = "mercury";
  nixpkgs.hostPlatform = "x86_64-linux";

  imports = [
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    initrd = {
      luks = {
        devices = {
          "luks-1774752a-ae6e-47b9-9fd2-0f3300ef53b6" = {
            device = "/dev/disk/by-uuid/1774752a-ae6e-47b9-9fd2-0f3300ef53b6";
          };
        };
      };
    };
    tmp.cleanOnBoot = true;
  };
  swapDevices = [
    { device = "/dev/disk/by-uuid/d032b92b-ead4-4014-a3f3-bdf16582dd19"; }
  ];
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/D7F6-A4DF";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
    "/" = {
      device = "/dev/disk/by-uuid/dd77631b-dd75-451a-b56a-df495e06f1a3";
      fsType = "ext4";
    };
  };

  system.stateVersion = "24.04"; # do not change
}
