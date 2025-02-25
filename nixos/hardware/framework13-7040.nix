{ pkgs, ... }:
let
  framework-grub-theme = builtins.fetchTarball {
    url = "https://github.com/AdisonCavani/distro-grub-themes/releases/download/v3.2/framework.tar";
    sha256 = "1asgwgf5hd888jhi8lgsm1f5ayjbzv777dgahwv4fmnjph0swcaz";
  };
in
{
  imports = [
    <nixos-hardware/framework/13-inch/7040-amd>
    ./thunderbolt.nix
  ];

  hardware = {
    framework = {
      laptop13 = {
        audioEnhancement = {
          enable = false;
          hideRawDevice = false;
        };
      };
      amd-7040.preventWakeOnAC = true;
      enableKmod = true;
    };
  };

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    loader.grub = {
      theme = "${framework-grub-theme}";
    };
  };
}
