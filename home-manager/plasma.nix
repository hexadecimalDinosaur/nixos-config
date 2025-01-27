{ pkgs, ... }:
{
  imports = [
    <plasma-manager/modules>
  ];

  programs.plasma = {
    enable = true;
  };
}
