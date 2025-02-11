{ pkgs, ... }:
{
  imports = [
    <nixos-hardware/framework/13-inch/7040-amd>
    ./thunderbolt.nix
  ];

  hardware = {
    framework = {
      laptop13 = {
        audioEnhancement = {
          enable = true;
          hideRawDevice = false;
        };
      };
      amd-7040.preventWakeOnAC = true;
      enableKmod = true;
    };
  };

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
}
