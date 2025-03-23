{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    nixpkgs-unstable.url = "flake:nixpkgs-unstable";

    nixpkgs-overlays = {
      url = "./nixpkgs-overlays";
      inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    };

    home-manager = {
      url = "flake:home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs :
  {
    nixosConfigurations = {
      cobalt = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          self.nixosModules.default
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          ./hosts/cobalt
          ./users/hexa

          self.nixosModules.plasma
          self.nixosModules.ricing
          self.nixosModules.dev
          self.nixosModules.media
          self.nixosModules.games
          self.nixosModules.office

          self.nixosModules.virtualization
          self.nixosModules.ld
        ];
      };
      mercury = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          self.nixosModules.default
          ./hosts/mercury
          ./users/hexa

          self.nixosModules.plasma
          self.nixosModules.ricing
          self.nixosModules.dev
          self.nixosModules.media
          self.nixosModules.games
          self.nixosModules.office

          self.nixosModules.virtualization
        ];
      };
    };
    nixosModules = {
      hardware = ./hardware;

      plasma = ./packages/plasma.nix;       # plasma packages and setup
      packages = ./packages;                # common packages
      ricing = ./packages/ricing.nix;       # ricing packages
      dev = ./packages/dev.nix;             # basic dev packages
      media = ./packages/media.nix;         # media packages
      games = ./packages/games.nix;         # gaming packages
      office = ./packages/office.nix;       # common packages

      nixpkgs-overlays = { inputs, ... }: {
        nixpkgs.overlays = [
          inputs.nixpkgs-overlays.overlays.unstable
          inputs.nixpkgs-overlays.overlays.plasma
          inputs.nix-alien.overlays.default
        ];
      };

      agenix = { pkgs, ... }: {
        imports = [ inputs.agenix.nixosModules.default ];
        environment.systemPackages = [
          inputs.agenix.packages.${pkgs.system}.default
        ];
      };

      registry = {
        nix.registry = {
          nixpkgs = {
            from = { id = "nixpkgs"; type = "indirect"; };
            to = { type = "path"; path = inputs.nixpkgs; };
          };
          nixpkgs-unstable = {
            from = { id = "nixpkgs-unstable"; type = "indirect"; };
            to = { type = "path"; path = inputs.nixpkgs-unstable; };
          };
          home-manager = {
            from = { id = "home-manager"; type = "indirect"; };
            to = { type = "path"; path = inputs.home-manager; };
          };
        };
      };

      bootloader = ./modules/bootloader.nix;         # bootloader (GRUB)
      nix = ./modules/nix.nix;                       # nix and nixpkgs settings and nix tools
      networking = ./modules/networking.nix;         # networking config
      vpn = ./modules/vpn.nix;                       # vpn configuration (openvpn, openconnect, tailscale)
      locale = ./modules/locale.nix;                 # timezone, dictionaries, i18n, input methods
      fonts = ./modules/fonts.nix;                   # fonts
      security = ./modules/security;                 # firewall, auditd, etc.
      virtualization = ./modules/virtualization.nix; # VMs, docker
      ld = ./modules/ld.nix;                         # nix-ld

      default = { ... }: {
        imports = [
          self.nixosModules.nixpkgs-overlays
          self.nixosModules.hardware
          self.nixosModules.packages
          self.nixosModules.bootloader
          self.nixosModules.nix
          self.nixosModules.networking
          self.nixosModules.vpn
          self.nixosModules.locale
          self.nixosModules.fonts
          self.nixosModules.security
          self.nixosModules.registry
          self.nixosModules.agenix
          inputs.lix-module.nixosModules.default
        ];

        services = {
          xserver = {
            enable = true;
            xkb = {
              layout = "us";
              variant = "";
            };
          };
        };
      };
    };
  };
}
