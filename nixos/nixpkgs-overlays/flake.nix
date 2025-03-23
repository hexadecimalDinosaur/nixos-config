{
  inputs = {
    nixpkgs-unstable.url = "flake:nixpkgs-unstable";
  };
  outputs = { nixpkgs-unstable, ... } : {
    overlays = rec {
      plasma = import ./plasma.nix;
      unstable = import ./unstable.nix { inherit nixpkgs-unstable; };

      default = unstable;
    };
  };
}
