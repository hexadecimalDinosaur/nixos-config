{ spicetify-nix }:
(
  final: prev:
  {
    spicePkgs = spicetify-nix.legacyPackages.${prev.system};
  }
)
