{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-tree").setup()
        '';
      }
      taboo-vim
      zoxide-vim
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local builtin = require('telescope.builtin')
          local previewers = require("telescope.previewers")

          require "telescope".setup {
            pickers = {
              find_files = {
                enable_preview = true,
              }
            }
          }

          vim.keymap.set('n', 'ft', builtin.pickers, { desc = 'Telescope' })
          vim.keymap.set('n', 'ff', builtin.find_files, { desc = 'Telescope find files' })
          vim.keymap.set('n', 'fg', builtin.live_grep, { desc = 'Telescope live grep' })
          vim.keymap.set('n', 'fb', builtin.buffers, { desc = 'Telescope buffers' })
          vim.keymap.set('n', 'fh', builtin.help_tags, { desc = 'Telescope help tags' })
          vim.keymap.set('n', 'fs', builtin.lsp_document_symbols, { desc = 'Telescope document symbols' })
          vim.keymap.set('n', '<F8>', builtin.lsp_document_symbols, { desc = 'Telescope document symbols' })
          vim.keymap.set('n', 'fr', builtin.lsp_references, { desc = 'Telescope document references' })
          vim.keymap.set('n', 'fc', builtin.git_commits, { desc = 'Telescope Git Commits' })
          vim.keymap.set('n', 'f>', builtin.commands, { desc = 'Telescope Commands' })
          vim.keymap.set('n', '<C-P>', builtin.commands, { desc = 'Telescope Commands' })
          vim.keymap.set('n', '<-/>', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzy search' })
        '';
      }
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      {
        plugin = lsp-zero-nvim;
        type = "lua";
        config = ''
          vim.opt.signcolumn = 'yes'
          local lspconfig_defaults = require('lspconfig').util.default_config
          lspconfig_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig_defaults.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
          )
          vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
              local opts = {buffer = event.buf}

              vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
              vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
              vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
              vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
              vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
              vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
              vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
              vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
              vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
              vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
            end,
          })
        '';
      }
      {
        plugin = lightline-vim;
        type = "viml";
        config = ''
          let g:lightline = {
                \ 'colorscheme': 'one',
                \ 'active':{
                \ 'right':[ ['lineinfo'],['percent'],[ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex', 'currentfunction' ] ]
                \ },
                \ 'conponent': {
                \   'charvaluehex':'%B',
                \   'cocstatus': 'coc#status',
                \   'currentfunction': 'CocCurrentFunction'
                \ },
                \ 'separator': { 'left': '', 'right': '' },
                \ 'subseparator': { 'left': '', 'right': '' }
                \ }
        '';
      }
      vim-sleuth
      # vimtex
      codi-vim
      tokyonight-nvim
      dracula-nvim
      catppuccin-nvim
      luasnip
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          local cmp = require('cmp')
          local cmp_action = require('lsp-zero').cmp_action()

          cmp.setup({
            sources = {
              {name = 'nvim_lsp'},
            },
            snippet = {
              expand = function(args)
                -- You need Neovim v0.10 to use vim.snippet
                vim.snippet.expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({}),
          })

          cmp.setup({
            mapping = cmp.mapping.preset.insert({
              ['<CR>'] = cmp.mapping.confirm({select = false}),
              ['<Tab>'] = cmp_action.luasnip_supertab(),
              ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
            }),
            snippet = {
              expand = function(args)
                require('luasnip').lsp_expand(args.body)
              end,
            },
          })

          require'lspconfig'.pyright.setup{}
          require'lspconfig'.nixd.setup{}
          require'lspconfig'.marksman.setup{}
          require'lspconfig'.jdtls.setup{}
          require'lspconfig'.jsonls.setup{}
          require'lspconfig'.html.setup{}
          require'lspconfig'.cssls.setup{}
          require'lspconfig'.eslint.setup{}
          require'lspconfig'.clangd.setup{}
          require'lspconfig'.bashls.setup{}
          require'lspconfig'.yamlls.setup{}
        '';
      }
      cmp-nvim-lsp
    ];
    extraLuaConfig = ''
      vim.opt.number = true
      vim.opt.laststatus = 2
      vim.opt.cursorline = true
      vim.api.nvim_set_hl(0, "CursorLineNR", { ctermbg=grey })
      vim.cmd([[colorscheme catppuccin-mocha]])
      function show_nvim_tree()
        vim.cmd([[NvimTreeToggle]])
      end
      vim.keymap.set("n", "<C-f>", show_nvim_tree)
      vim.keymap.set("n", "<C-t>", ":tabnew<CR>")
    '';
  };
}
