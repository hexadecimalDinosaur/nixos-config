{ config, lib, pkgs, ... }:

{
  imports = [
    ./audio.nix     # pipewire setup
    ./yubikey.nix   # yubikey support
    ./qmk.nix       # qmk keyboard support
    ./wacom.nix     # wacom tablet support
    ./rf-tools.nix  # rtl-sdr, flipperzero, proxmark
    ./gps.nix       # usb gps reciever
  ];

  config = {
    networking.useDHCP = lib.mkDefault true;

    boot = {
      initrd = {
        availableKernelModules = [ "nvme" "xhci_pci" "uas" "sd_mod" ];
        kernelModules = [ "amdgpu" ];
      };
      kernelModules = [ "kvm-amd" ];
      extraModulePackages = [ ];
    };

    hardware = {
      enableRedistributableFirmware = lib.mkDefault true;
      cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      graphics = {
        extraPackages = with pkgs; [
          amdvlk
          rocmPackages.clr.icd
        ];
        extraPackages32 = with pkgs; [
          driversi686Linux.amdvlk
        ];
      };

      bluetooth = {
        enable = true;
        powerOnBoot = false;
      };
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
      kdePackages.colord-kde
      # bluetooth
      bluetui
      bluetuith
    ];

    # boot.extraModulePackages = with config.boot.kernelPackages; [ zenpower ];
  };
}
