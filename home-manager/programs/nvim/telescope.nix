{ pkgs, lib, ... }:
{
  programs.neovim = {
    plugins = lib.mkBefore (with pkgs.vimPlugins; [
      plenary-nvim
      telescope-fzf-native-nvim

      {
        plugin = telescope-nvim;
        type = "lua";
        config = /* lua */ ''
          local telescope = require('telescope')
          local builtin = require('telescope.builtin')
          local previewers = require("telescope.previewers")

          telescope.setup {
            pickers = {
              find_files = {
                enable_preview = true,
              },
              help_tags = {
                theme = "dropdown",
              },
              current_buffer_fuzzy_find = {
                theme = "dropdown",
              },
              commands = {
                theme = "ivy",
              },
              colorscheme = {
                enable_preview = true,
                theme = "dropdown",
              },
            },
            extensions = {
              fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
              },
            },
          }
          telescope.load_extension('fzf')
        '';
      }

      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          name = "commander";
          src = pkgs.fetchFromGitHub {
            owner = "FeiyouG";
            repo = "commander.nvim";
            tag = "v0.2.0";
            hash = "sha256-yXZlm7/9f8VCdVGoAnqHLJBv9+76S0UoyzO8I9BIOws=";
          };
          meta.homepage = "https://github.com/FeiyouG/commander.nvim";
        };
        type = "lua";
        config = /* lua */ ''
          commander = require('commander')
          local builtin = require('telescope.builtin')
          local previewers = require('telescope.previewers')

          commander.setup {
            components = {
              "DESC",
              "KEYS",
              "CAT",
            },
            separator = "\t",
            integration = {
              telescope = {
                enable = true,
              },
            },
          }

          commander.add({
            {
              desc = "Commander", keys = { "n", "f" },
              cmd = commander.show,
            },
            {
              desc = "Colorschemes", key = { "n", "fc" },
              cmd = builtin.colorscheme,
            },
          }, { cat = "", set = true, show = true })

          commander.add({
            {
              desc = "Projects", keys = { "n", "fp" },
              cmd = "<CMD>Telescope neovim-project<CR>",
            },
            {
              desc = "Telescope: files", keys = { "n", "ff" },
              cmd = builtin.find_files,
            },
            {
              desc = "Telescope: live grep", keys = { "n", "ffg" },
              cmd = builtin.live_grep,
            },
          }, { cat = "File", set = true, show = true })

          commander.add({
            {
              desc = "Fuzzy search current buffer", keys = { "n", "<C-_>" },
              cmd = builtin.current_buffer_fuzzy_find,
            },
            {
              desc = "Select filetype", keys = { "n", "f>f" },
              cmd = builtin.filetypes,
            },
          }, { cat = "Edit", set = true, show = true })

          commander.add({
            {
              desc = "Telescope: Buffers", keys = { "n", "fb" },
              cmd = builtin.buffers,
            },
            {
              desc = "Telescope: Commands", keys = { "n", "f>" },
              cmd = builtin.commands,
            },
            {
              desc = "Telescope: Commands", keys = { "n", "<C-P>" },
              cmd = builtin.commands, show = false,
            },
            {
              desc = "Telescope: Keymaps", keys = { "n", "f>k" },
              cmd = builtin.keymaps,
            },
            {
              desc = "Telescope: Resume", keys = { "n", "fr" },
              cmd = builtin.resume,
            },
          }, { cat = "Navigation", set = true, show = true })

          commander.add({
            {
              desc = "Telescope help tags", keys = { "n", "f?" },
              cmd = builtin.help_tags,
            },
            {
              desc = "Zeal: Search", keys = { "n", "z" },
              cmd = "<CMD>Zeavim!<CR>";
            },
          }, { cat = "Reference", set = true, show = true })

          commander.add({
            {
              desc = "Telescope: Treesitter symbols", keys = { "n", "fst" },
              cmd = builtin.treesitter,
            },
          }, { cat = "LSP", set = true, show = true })

          commander.add({
            {
              desc = "Telescope: Git status", keys = { "n", "fg" },
              cmd = builtin.git_status,
            },
            {
              desc = "Telescope: Git commits", keys = { "n", "fgc" },
              cmd = builtin.git_commits,
            },
            {
              desc = "Telescope: Git commits (curr buff.)", keys = { "n", "fgcb" },
              cmd = builtin.git_status,
            },
            {
              desc = "Telescope: Git branches", keys = { "n", "fgb" },
              cmd = builtin.git_branches,
            },
          }, { cat = "Git", set = true, show = true })
        '';
      }

      {
        plugin = telescope-manix;
        type = "lua";
        config = /* lua */ ''
          telescope.load_extension('manix')
          commander.add({
            {
              desc = "Manix: Search", keys = { "n", "fn" },
              cmd = function() telescope.extensions.manix.manix(require('telescope.themes').get_dropdown({})) end,
            },
          }, { cat = "Reference", set = true, show = true })
        '';
      }
      {
        plugin = telescope-zoxide;
        type = "lua";
        config = /* lua */ ''
          telescope.load_extension('zoxide')
          commander.add({
            {
              desc = "Zoxide", keys = { "n", "fz" },
              cmd = function() telescope.extensions.zoxide.list(require('telescope.themes').get_dropdown({})) end,
            }
          }, { cat = "File", set = true, show = true })
        '';
      }
      {
        plugin = telescope-undo-nvim;
        type = "lua";
        config = /* lua */ ''
          telescope.load_extension('undo')
          commander.add({
            {
              desc = "Undo tree", keys = { "n", "fu" },
              cmd = telescope.extensions.undo.undo,
            }
          }, { cat = "Edit", set = true, show = true })
        '';
      }
      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          name = "telescope-tabs";
          src = pkgs.fetchFromGitHub {
            owner = "LukasPietzschmann";
            repo = "telescope-tabs";
            rev = "0a678eefcb71ebe5cb0876aa71dd2e2583d27fd3";
            hash = "sha256-IvxZVHPtApnzUXIQzklT2C2kAxgtAkBUq3GNxwgPdPY=";
          };
          meta.homepage = "https://github.com/LukasPietzschmann/telescope-tabs";
        };
        type = "lua";
        config = /* lua */ ''
          require("telescope-tabs").setup({
            entry_formatter = function(tab_id, buffer_ids, file_names, file_paths, is_current)
              local entry_string = table.concat(vim.tbl_map(function(v)
                return vim.fn.fnamemodify(v, ":.")
              end, file_paths), ', ')
              return string.format('%d: %s%s', tab_id, entry_string, is_current and " <" or "")
            end
          })
          telescope.load_extension('telescope-tabs')
          commander.add({
            {
              desc = "Telescope: Tabs", keys = { "n", "ft" },
              cmd = function ()require('telescope-tabs').list_tabs(require('telescope.themes').get_dropdown({})) end,
            }
          }, { cat = "Navigation", set = true, show = true })
        '';
      }
      {
        plugin = pkgs.vimUtils.buildVimPlugin {
          name = "lsp-toggle";
          src = pkgs.fetchFromGitHub {
            owner = "adoyle-h";
            repo = "lsp-toggle.nvim";
            tag = "v1.1.1";
            hash = "sha256-Td5QrIvBhYmqH+rHfCjML6hel/KNvO7hdwUTAzZ3hns=";
          };
          meta.homepage = "https://github.com/adoyle-h/lsp-toggle.nvim";
        };
        type = "lua";
        config = /* lua */ ''
          require('lsp-toggle').setup({
            create_cmds = true,
            telescope = true,
          })
          commander.add({
            {
              desc = "LSP: Toggle", keys = { "n", "fl" },
              cmd = telescope.extensions.ToggleLSP.ToggleLSP,
            }
          }, { cat = "LSP", set = true, show = true })
        '';
      }
      {
        plugin = telescope-github-nvim;
        type = "lua";
        config = /* lua */ ''
          telescope.load_extension('gh')
          commander.add({
            {
              desc = "GitHub: Issues", keys = { "n", "fhi" },
              cmd = telescope.extensions.gh.issues,
            },
            {
              desc = "GitHub: PRs", keys = { "n", "fhp" },
              cmd = telescope.extensions.gh.pull_request,
            },
            {
              desc = "GitHub: Runs", keys = { "n", "fhr" },
              cmd = telescope.extensions.gh.run,
            },
          }, { cat = "GitHub", set = true, show = true })
        '';
      }
    ]);
  };
}
