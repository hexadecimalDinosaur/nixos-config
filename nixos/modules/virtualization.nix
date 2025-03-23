{ pkgs, ... }:
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

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
      };
    };
  };

  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu_kvm}/share/qemu/firmware" ];
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    # docker
    docker-compose
    distrobox
    distrobox-tui
    lazydocker
    x11docker
    arion
    # qemu
    qemu_kvm
    quickemu
    qemu-user
    nemu
  ] ++ virtualisation.docker.extraPackages;
}
