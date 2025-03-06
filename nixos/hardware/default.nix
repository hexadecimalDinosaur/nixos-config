{ config, lib, pkgs, ... }:

{
  imports = [
    ./audio         # pipewire setup
    ./bluetooth.nix # bluetooth setup
    ./yubikey.nix   # yubikey support
    ./qmk.nix       # qmk keyboard support
    ./wacom.nix     # wacom tablet support
    ./rf-tools.nix  # rtl-sdr, flipperzero, proxmark
    ./gps.nix       # usb gps reciever
  ];

  boot = {
    initrd = {
      availableKernelModules = [
        "nvme"      # nvme disk driver
        "xhci_pci"  # usb xhci driver
        "uas"       # usb storage driver
        "sd_mod"    # scsi disk driver
      ];
    };
    extraModulePackages = [ ];
  };

  services = {
    printing.enable = true;       # cups printers
    fwupd.enable = true;          # firmware management
    colord.enable = true;         # display color profiles
    libinput.enable = true;       # touchpad
  };


  environment.systemPackages = with pkgs; [
    # serial
    minicom
    # display
    colord
    # hardware info
    dmidecode
    smartmontools
    powertop
    usbutils
    pciutils
    lm_sensors
    acpi
    vrrtest
    clinfo
    # plasma settings support
    (lib.mkIf config.services.desktopManager.plasma6.enable kdePackages.colord-kde)
  ];

}
