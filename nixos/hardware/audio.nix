{ pkgs, ... }:
{
  # imports = [
  #   ./echo-cancellation.nix
  # ];

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
      #media-session.enable = true;
    };
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    jamesdsp
    qpwgraph
  ];
}
