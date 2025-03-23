{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovide
  ];

  programs.neovim.extraLuaConfig = /* lua */ ''
    if vim.g.neovide then
      vim.o.guifont = "JetBrainsMono Nerd Font Mono:h11"
    end
  '';
}
