{ pkgs, ... }:
{
  imports = [
    # ./echo-cancellation.nix
    # ./headphone-speaker-split.nix
  ];

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
      #media-session.enable = true;
      wireplumber.extraConfig = {
        bluetoothEnhancements = {
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
          };
        };
        setDefaultMicVolumme = {
          "wireplumber.settings" = {
            "device.routes.default-source-volume" = "0.008";
          };
        };
      };
    };
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    jamesdsp
    qpwgraph
    easyeffects
    bankstown-lv2
    lsp-plugins
    carla
    alsa-utils
  ];
}
