{ config, lib, ... }:
{
  imports = [
    ./../../hardware/amd.nix
  ];

  specialisation = {
    nvidia.configuration = {
      services.xserver.videoDrivers = ["nvidia"];
      hardware = {
        nvidia = {
          modesetting.enable = true;
          powerManagement.enable = {
            enable = false;
            finegrained = false;
          };
          open = true;
          nvidiaSettings = true;
          package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
      };
    };
  };

  boot = {
    extraModprobeConfig = ''
      blacklist nouveau
      options nouveau modeset=0
    '';
    blacklistedKernelModules = [
      "nouveau"
      (lib.mkIf (config.specialisation != {}) "nvidia")
      (lib.mkIf (config.specialisation != {}) "nvidia_drm")
      (lib.mkIf (config.specialisation != {}) "i2c_nvidia_gpu")
      (lib.mkIf (config.specialisation != {}) "nvidia_modeset")
    ];
    kernelParams = [ "amd_pstate=active" ];
  };

  services = {
    xserver.videoDrivers = [
      (lib.mkIf (config.specialisation != {}) "amdgpu")
    ];
    asusd = {
      enable = true;
      enableUserService = true;
      asusdConfig = ''
        (
            charge_control_end_threshold: 100,
            panel_od: false,
            boot_sound: false,
            mini_led_mode: false,
            disable_nvidia_powerd_on_battery: true,
            ac_command: "",
            bat_command: "",
            throttle_policy_linked_epp: true,
            throttle_policy_on_battery: Quiet,
            change_throttle_policy_on_battery: true,
            throttle_policy_on_ac: Quiet,
            change_throttle_policy_on_ac: true,
            throttle_quiet_epp: Power,
            throttle_balanced_epp: BalancePower,
            throttle_performance_epp: Performance,
        )
      '';
    };
    udev.extraRules = (lib.mkIf (config.specialisation != {}) /* udev */ ''
      # Remove NVIDIA USB xHCI Host Controller devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
      # Remove NVIDIA USB Type-C UCSI devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
      # Remove NVIDIA Audio devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
      # Remove NVIDIA VGA/3D controller devices
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
    '');
  };
}
