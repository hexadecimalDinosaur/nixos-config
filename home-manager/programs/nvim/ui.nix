{ pkgs, lib, ... }:
{
  programs.neovim = {
    plugins = lib.mkBefore (with pkgs.vimPlugins; [
      tokyonight-nvim
      dracula-nvim
      catppuccin-nvim
      nvim-web-devicons

      {
        plugin = lualine-nvim;
        type = "lua";
        config = /* lua */ ''
          require('lualine').setup {
            options = {
              icons_enabled = true,
              theme = 'auto',
              component_separators = { left = '', right = ''},
              section_separators = { left = '', right = ''},
              disabled_filetypes = {
                statusline = {'NvimTree', 'alpha'},
                winbar = {},
              },
              ignore_focus = {},
              always_divide_middle = true,
              always_show_tabline = true,
              globalstatus = false,
             refresh = {
                statusline = 100,
                tabline = 100,
                winbar = 100,
              }
            },
            sections = {
              lualine_a = {'mode'},
              lualine_b = {'branch', 'diff'},
              lualine_c = {'filename'},
              lualine_x = {'encoding', 'fileformat', 'filetype', '%B'},
              lualine_y = {'progress'},
              lualine_z = {'location'}
            },
            inactive_sections = {
              lualine_a = {},
              lualine_b = {},
              lualine_c = {'filename'},
              lualine_x = {'location'},
              lualine_y = {},
              lualine_z = {}
            },
            tabline = {
              lualine_a = {
                {
                  'tabs',
                  tab_max_length = 20,
                  max_length = vim.o.columns / 4 * 3,
                  mode = 1,
                  path = 1,
                  use_mode_colors = false,
                  show_modified_status = true,
                  symbols = {
                    modified = '󰏫',
                  },
                }
              },
              lualine_b = {},
              lualine_c = {},
              lualine_x = {},
              lualine_y = {'diagnostics'},
              lualine_z = {},
            },
            winbar = {},
            inactive_winbar = {},
            extensions = {}
          }
        '';
      }
    ]);

    extraLuaConfig = /* lua */ ''
      vim.opt.number = true
      vim.opt.laststatus = 2
      vim.opt.cursorline = true
      vim.api.nvim_set_hl(0, "CursorLineNR", { ctermbg=grey })
    '';
    extraConfig = /* vim */ ''
      colorscheme catppuccin-mocha
    '';
  };
}
