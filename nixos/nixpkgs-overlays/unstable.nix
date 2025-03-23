{ nixpkgs-unstable }:
(
  final: prev:
  {
    unstable = import nixpkgs-unstable {
      inherit (prev) system config;
    };
  }
)
