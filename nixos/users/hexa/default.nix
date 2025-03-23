{ pkgs, config, lib, ... }:
{
  users.users.hexa = {
    description = "Ivy Fan-Chiang";
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel" # sudo
      (lib.mkIf config.virtualisation.docker.enable "docker")
      "dialout" # serial access
      "plugdev" # usb device access
      (lib.mkIf config.security.tpm2.pkcs11.enable "tss")
      (lib.mkIf config.services.colord.enable "colord")
      (lib.mkIf config.virtualisation.libvirtd.enable "libvirtd")
      "kvm"
      (lib.mkIf config.programs.adb.enable "adbusers")
      (lib.mkIf config.programs.weylus.enable "uinput")
    ];
    shell = pkgs.zsh;
  };
}
