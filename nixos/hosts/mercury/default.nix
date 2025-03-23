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
        };
      };
    };
    tmp.cleanOnBoot = true;
  };
  swapDevices = [
  ];
  fileSystems = {
  };

  system.stateVersion = "24.04"; # do not change
}
