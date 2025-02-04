{ pkgs, ... }:
{
  hardware.keyboard.qmk.enable = true;

  environment.systemPackages = with pkgs; [
    via
    qmk_hid
  ];
}
