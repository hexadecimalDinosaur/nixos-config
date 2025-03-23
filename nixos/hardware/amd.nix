{ config, pkgs, ... }:
{
  boot = {
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = with config.boot.kernelPackages; [
      # zenpower
    ];
  };

  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;

    graphics = {
      extraPackages = with pkgs; [
        amdvlk
        rocmPackages.clr.icd
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };

    amdgpu.initrd.enable = true;
  };
}
