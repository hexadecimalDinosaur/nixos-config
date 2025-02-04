{ ... }:
{
  services = {
    pipewire.extraConfig.pipewire = {
      "60-echo-cancel" = {
        "context.modules" = [
          {
            "name" = "libpipewire-module-echo-cancel";
            "args" = {
              "monitor.mode" = true;
              "source.props" = {
                "node.name" = "source_ec";
                "node.description" = "Echo-cancelled source";
              };
              "aec.args" = {
                "webrtc.gain_control" = true;
                "webrtc.extended_filter" = false;
              };
            };
          }
        ];
      };
    };
  };
}
