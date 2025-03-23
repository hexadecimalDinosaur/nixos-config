{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    nixpkgs-unstable.url = "flake:nixpkgs-unstable";

    home-manager = {
      url = "flake:home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "flake:nixos-config-secrets";
      flake = false;
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs, home-manager, nixpkgs-unstable, spicetify-nix, secrets, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (import ./overlays/unstable.nix { inherit nixpkgs-unstable; })
          (import ./overlays/spicetify.nix { inherit spicetify-nix; })
        ];
      };
    in {
      homeConfigurations."hexa" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit secrets;
        };

        modules = [
          ./home.nix
          spicetify-nix.homeManagerModules.spicetify
        ];
      };
    };
}
