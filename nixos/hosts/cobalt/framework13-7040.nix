{ pkgs, ... }:
let
  framework-grub-theme-hidpi = pkgs.fetchzip {
    url = "https://github.com/mrjpaxton/framework-hidpi-grub-theme/raw/4f94efc3559e4e6ca2714382c930fb031a9563b7/framework-hidpi.tar.gz";
    hash = "sha256-NOX/I+zT9HTsWPkx/u9eLM2vuiudhDjSULgj/es18L0=";
    postFetch = ''
      cp "$out/theme-dark.txt" "$out/theme.txt"
    '';
  };
in
{
  imports = [
    ./../../hardware/amd.nix
    ./../../hardware/thunderbolt.nix
    ( import ./../../hardware/audio/headphone-speaker-split.nix {
      codec = "ALC295";
      pcie-vendor-id = "0x1022";
      pcie-device-id = "0x15e3";
      alsa-vendor-id = "0x10ec0295";
      alsa-subsystem-id = "0x10ec0295";
    })
  ];

  hardware = {
    framework = {
      laptop13 = {
        audioEnhancement = {
          enable = false;
          hideRawDevice = false;
          rawDeviceName = "alsa_output.pci-0000_c1_00.6.analog-stereo-speaker";
        };
      };
      amd-7040.preventWakeOnAC = true;
      enableKmod = true;
    };
  };

  services.pipewire.wireplumber.extraConfig = {
    framework-defaults = {
      "wireplumber.settings" = {
        "device.restore-routes" = false;
      };
      "monitor.alsa.rules" = [
        {
          matches = [
            { "device.name" = "alsa_card.pci-0000_c1_00.6"; }
          ];
          actions = {
            update-props = {
              "device.profile" = "output:analog-stereo-headphones+output:analog-stereo-speaker+input:analog-stereo-input";
              "device.description" = "Framework 13";
            };
          };
        }
        {
          matches = [
            { "device.name" = "alsa_input.pci-0000_c1_00.6.analog-stereo-input"; }
          ];
          actions = {
            update-props = {
            };
          };
        }
      ];
    };
  };

  boot = {
    loader.grub = {
      theme = "${framework-grub-theme-hidpi}";
    };
  };

  environment.sessionVariables = {
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
}
