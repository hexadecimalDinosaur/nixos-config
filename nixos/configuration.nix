{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix  # auto-generated config (do not edit)
      # personal config
      ./modules/hardware.nix
      ./modules/locale.nix
      ./modules/packages.nix
      ./modules/fonts.nix
      ./modules/vpn.nix
      ./modules/firewall.nix
      # lix
      (let
        module = fetchTarball {
          name = "source";
          url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";
          sha256 = "sha256-DN5/166jhiiAW0Uw6nueXaGTueVxhfZISAkoxasmz/g=";
        };
        lixSrc = fetchTarball {
          name = "source";
          url = "https://git.lix.systems/lix-project/lix/archive/2.91.1.tar.gz";
          sha256 = "sha256-hiGtfzxFkDc9TSYsb96Whg0vnqBVV7CUxyscZNhed0U=";
        };
        in import "${module}/module.nix" { lix = lixSrc; }
      )
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = false;
    efiSupport = true;
  };

  networking.networkmanager = {
    enable = true;
    # wifi.powersave = true;
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hexa = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" "dialout" "plugdev" ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
  ];
  programs.zsh.enable = true;
  programs.ssh.startAgent = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
  };

  fileSystems."/tmp" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "size=16G" "mode=777" ];
  };

  services.gvfs.enable = true;
  #services.envfs.enable = true;
  security.auditd.enable = true;
  security.audit.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.vmware.host.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    zlib
    stdenv.cc.cc
  ];

  system.stateVersion = "24.11"; # Did you read the comment?

}
