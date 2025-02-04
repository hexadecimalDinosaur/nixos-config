{ pkgs, config, lib, ... }:
rec
{ 
  virtualisation = {
    docker = {
      enable = true;
      extraPackages = with pkgs; [
        criu
        docker-credential-helpers
      ];
    };

    vmware.host.enable = true;

    # libvirtd = {
    #   enable = true;
    #   qemu = {
    #     package = pkgs.qemu_kvm;
    #     runAsRoot = true;
    #     swtpm.enable = true;
    #     vhostUserPackages = [ pkgs.virtiofsd ];
    #     ovmf = {
    #       enable = true;
    #       packages = [(pkgs.OVMF.override {
    #         secureBoot = true;
    #         tpmSupport = true;
    #       }).fd];
    #     };
    #   };
    # };
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    distrobox
    distrobox-tui
    lazydocker
    x11docker
  ] ++ virtualisation.docker.extraPackages;
}
