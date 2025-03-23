{ ... }:
{
  services.pipewire.extraConfig = {
    pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 96000;
        "default.clock.allowed-rates" = [ 48000 96000 192000 384000 ];
        "default.clock.quantum" = 512;
        "default.clock.min-quantum" = 256;
        "default.clock.max-quantum" = 1024;
      };
    };
    pipewire-pulse."92-low-latency" = {
      context.modules = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse.min.req = "256/192000";
            pulse.default.req = "512/96000";
            pulse.max.req = "1024/48000";
            pulse.min.quantum = "256/192000";
            pulse.max.quantum = "1024/48000";
          };
        }
      ];
      stream.properties = {
        node.latency = "512/96000";
        resample.quality = 1;
      };
    };
  };
}
