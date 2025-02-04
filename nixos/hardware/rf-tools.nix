{ pkgs, ... }:
{
  hardware = {
    flipperzero.enable = true;
    rtl-sdr.enable = true;
  };

  environment.systemPackages = with pkgs; [
    qflipper
    proxmark3
    rtl-sdr
    gqrx
  ];
}
