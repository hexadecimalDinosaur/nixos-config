{
  description = "Configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-overlays = {
      url = "./nixos/nixpkgs-overlays";
      inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    };
    nixos-config = {
      url = "./nixos";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs-overlays.follows = "nixpkgs-overlays";
    };
    home-manager-config = {
      url = "./home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { nixos-config, home-manager-config, nixpkgs-overlays, ... }: {
    nixosConfigurations = nixos-config.nixosConfigurations;
    homeConfigurations = home-manager-config.homeConfigurations;

    overlays = nixpkgs-overlays;
  };
}
