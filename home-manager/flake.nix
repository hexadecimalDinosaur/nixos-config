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
  };

  outputs = { nixpkgs, home-manager, nixpkgs-unstable, secrets, ... }:
    let
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "olm-3.2.16"
          "electron-31.7.7"
          "cinny-4.2.3"
          "cinny-unwrapped-4.2.3"
        ];
      };
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          inherit config;
        };
      };
      pkgs = import nixpkgs {
        inherit system;
        inherit config;
        overlays = [ overlay-unstable ];
      };
    in {
      homeConfigurations."hexa" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit secrets;
        };

        modules = [ ./home.nix ];
      };
    };
}
