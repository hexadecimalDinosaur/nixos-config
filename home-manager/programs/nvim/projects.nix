{ pkgs, ... }:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      plenary-nvim

      {
        plugin = taboo-vim;
        type = "lua";
        config = /* lua */ ''
          vim.keymap.set("n", "<C-R>", ":TabooRename ")
        '';
      }

      (pkgs.vimUtils.buildVimPlugin {
        name = "session_manager";
        src = pkgs.fetchFromGitHub {
          owner = "Shatur";
          repo = "neovim-session-manager";
          rev = "3409dc920d40bec4c901c0a122a80bee03d6d1e1";
          hash = "sha256-k2akj/s6qJx/sCnz3UNHo5zbENTpw+OPuo2WPF1W7rg=";
        };
        meta.homepage = "https://github.com/Shatur/neovim-session-manager";
      })

      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          name = "neovim-projects";
          src = pkgs.fetchFromGitHub {
            owner = "coffebar";
            repo = "neovim-project";
            rev = "3ca01f19a6405334bf1f652126e63f1229ad0e74";
            hash = "sha256-PdZ2H3S5D5zu66mqeESYOj8QNXvbLe5oWOG7ZTZTGfo=";
          };
          meta.homepage = "https://github.com/coffebar/neovim-project";
        };
        type = "lua";
        config = /* lua */ ''
          require("neovim-project").setup({
            projects = {
              "~/git/*",
              "~/git/nixos-config/*",
              "~/git/infrastructure/*",
              "~/Nextcloud/Documents/Projects/*"
            },
            dashboard_mode = true,
          })
        '';
      }

      {
        plugin = alpha-nvim;
        type = "lua";
        config = /* lua */ ''
          local dashboard = require('alpha.themes.dashboard');
          dashboard.section.buttons.val = {
            dashboard.button("e", "  New file", "<cmd>ene <CR>"),
            dashboard.button("f f", "󰈞  Find file"),
            dashboard.button("<C-f>", "  File tree"),
            dashboard.button("f p", "  Projects"),
            dashboard.button("f g", "  Git status"),
            dashboard.button("f f g", "󰈬  Find word"),
            dashboard.button("f >", "  NeoVim Commands"),
            dashboard.button("f n", "󰂺  Manix"),
          }
          require('alpha').setup(
            dashboard.config
          )
        '';
      }
    ];
  };
}
