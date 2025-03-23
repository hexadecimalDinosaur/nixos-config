{ ... }:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        useOSProber = false;
        efiSupport = true;
        configurationLimit = 10;
      };
    };
  };
}
