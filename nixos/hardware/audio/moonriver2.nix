{ ... }:
{
  services.pipewire.wireplumber.extraConfig = {
    framework-defaults = {
      "wireplumber.settings" = {
        "device.restore-routes" = false;
      };
      "monitor.alsa.rules" = [
        {
          matches = [
            { "device.name" = "alsa_card.usb-MOONDROP_Moonriver_2_Moonriver_2-00"; "alsa.components" = "USB2fc6:f066"; }
          ];
          actions = {
            update-props = {
              "device.profile" = "pro-audio";
              "audio.rate" = 192000;
              "audio.format" = "S32LE";
            };
          };
        }
      ];
    };
  };
}
