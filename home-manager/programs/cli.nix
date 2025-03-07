{ pkgs, ... }:
{
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    bat = {
      enable = true;
      config = {
        theme = "Tokyo Night";
      };
      themes = {
        "Tokyo Night" = {
          src = "${pkgs.vimPlugins.tokyonight-nvim.out}/extras/sublime";
          file = "tokyonight_night.tmTheme";
        };
        "Tokyo Storm" = {
          src = "${pkgs.vimPlugins.tokyonight-nvim.out}/extras/sublime";
          file = "tokyonight_storm.tmTheme";
        };
        "Tokyo Moon" = {
          src = "${pkgs.vimPlugins.tokyonight-nvim.out}/extras/sublime";
          file = "tokyonight_moon.tmTheme";
        };
        "Tokyo Day" = {
          src = "${pkgs.vimPlugins.tokyonight-nvim.out}/extras/sublime";
          file = "tokyonight_day.tmTheme";
        };
      };
    };
  };
  home.file = {
    ".local/bin/syscat" = {
      source = ./../scripts/syscat;
      executable = true;
    };
  };
}
