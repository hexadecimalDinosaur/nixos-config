{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs ={
    nixpkgs,
    nixpkgs-unstable,
    nixos-hardware,
    lix-module,
    agenix,
    ...
  }: {
    nixosConfigurations = {
      cobalt = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          unstable = import nixpkgs-unstable {
            allowUnfree = true;
            inherit system;
          };
        };
        modules = [
          ./configuration.nix
          ./hosts/cobalt
          ./users/hexa

          lix-module.nixosModules.default
          nixos-hardware.nixosModules.framework-13-7040-amd
          agenix.nixosModules.default
          { environment.systemPackages = [ agenix.packages.${system}.default ]; }
        ];
      };
    };
  };
}
