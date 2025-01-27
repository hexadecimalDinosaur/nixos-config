{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    <nixos-hardware/framework/13-inch/7040-amd>
  ];
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    framework.laptop13 = {
      audioEnhancement = {
        enable = true;
        hideRawDevice = false;
      };
    };

    flipperzero.enable = true;  # flipperzero udev rules
    rtl-sdr.enable = true;
  };

  services = {
    udev = {
      packages = with pkgs; [
        yubikey-personalization
        displaylink
      ];
      extraRules = ''
        KERNEL=="ttyACM[0-9]*", SUBSYSTEM=="tty", SUBSYSTEMS=="usb", ATTRS{idVendor}=="1546", ATTRS{idProduct}=="01a7", SYMLINK+="gps-tty"
      '';
    };

    fwupd.enable = true;          # firmware management
    hardware.bolt.enable = true;  # thunderbolt
    pcscd.enable = true;          # smartcards
    colord.enable = true;         # display color profiles
    libinput.enable = true;       # touchpad
    
    xserver = {
      wacom.enable = true;     # wacom tablet
    };

    # pipewire.extraConfig.pipewire = {
    #   "60-echo-cancel" = {
    #     "context.modules" = [
    #       {
    #         "name" = "libpipewire-module-echo-cancel";
    #         "args" = {
    #           "monitor.mode" = true;
    #           "source.props" = {
    #             "node.name" = "source_ec";
    #             "node.description" = "Echo-cancelled source";
    #           };
    #           "aec.args" = {
    #             "webrtc.gain_control" = true;
    #             "webrtc.extended_filter" = false;
    #           };
    #         };
    #       }
    #     ];
    #   };
    # };

    gpsd = {
      enable = true;
      readonly = false;
      devices = [
        "/dev/gps-tty"
      ];
    };

  };
  systemd.services.gpsd.enable = false;

  programs = {
    yubikey-touch-detector = {
      enable = true;
      libnotify = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # audio
    jamesdsp
    qpwgraph
    # wacom
    xf86_input_wacom
    libwacom
    # yubikey/smartcards
    pcscliteWithPolkit
    # qmk keyboards
    via
    # security hardware
    yubioath-flutter
    yubikey-manager
    yubikey-personalization-gui
    qflipper
    proxmark3
    # serial
    minicom
    # hubs
    displaylink
    # radio
    rtl-sdr
    gqrx
    gpsd
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
    # plasma settings support
    kdePackages.wacomtablet
    kdePackages.plasma-thunderbolt
    kdePackages.colord-kde
  ];

  # boot.extraModulePackages = with config.boot.kernelPackages; [ zenpower ];
}
