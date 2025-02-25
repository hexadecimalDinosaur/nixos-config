{ unstable }: { pkgs, ... }:
{
  home.packages = with unstable; [
    nixfmt-rfc-style
    nixpkgs-review
    hydra-check
    nix-index
    nix-du
    nix-btm
    nix-inspect
  ];
}
