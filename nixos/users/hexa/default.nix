{ pkgs, ... }:
{
  users.users.hexa = {
    description = "Ivy Fan-Chiang";
    isNormalUser = true;
    extraGroups = [
      "networkmanager"  # manage networking
      "wheel"           # sudo
      "docker"          # docker admin
      "dialout"         # serial access
      "plugdev"         # usb device access
      "tss"             # tpm2 access
      "colord"          # colord access
      "libvirtd"        # libvirtd VMs access
      "kvm"             # kvm access
      "adbusers"        # adb access
      "uinput"          # uinput for weylus
    ];
    shell = pkgs.zsh;
  };
}
