{ ... }:
{
  imports = [
    ./cli-tools.nix
    ./misc.nix
    ./security-tools.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "olm-3.2.16"
      "electron-27.3.11"
      "cinny-4.2.2"
      "python-2.7.18.8"
      "dotnet-sdk-wrapped-7.0.410"
      "dotnet-sdk-7.0.410"
    ];
  };
}
