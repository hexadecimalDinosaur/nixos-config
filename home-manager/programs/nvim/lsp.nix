{ pkgs, lib, ... }:
{
  programs.neovim = {
    plugins = lib.mkAfter (with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      lsp-status-nvim
      {
        plugin = lsp-zero-nvim;
        type = "lua";
        config = /* lua */ ''
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
              require('lsp-status').update_current_function()
              local binds_new = true
              local opts = {}
              for _, item in ipairs(commander.layer.cache_commands) do
                if item.desc == "LSP: Rename" then
                  binds_new = false
                  break
                end
              end

              commander.add({
                {
                  desc = "Telescope: Document Symbols", keys = { "n", "fs", opts },
                  cmd = builtin.lsp_document_symbols,
                },
                {
                  desc = "Telescope: Document Symbols", keys = { "n", "<F8>", opts },
                  cmd = builtin.lsp_document_symbols, show = false,
                },
                {
                  desc = "Telescope: References", keys = { "n", "fsr", opts },
                  cmd = builtin.lsp_references,
                },
                {
                  desc = "Telescope: Definitions", keys = { "n", "fsd", opts },
                  cmd = builtin.lsp_definitions,
                },
                -- {
                --   desc = "Telescope: Implementations", keys = { "n", "fsi", opts },
                --   cmd = builtin.lsp_implementaions,
                -- },
                {
                  desc = "LSP: Rename", keys = { "n", "<F2>", opts },
                  cmd = vim.lsp.buf.rename,
                },
                {
                  desc = "LSP: Reformat", keys = { {"n", "x"}, "<F3>", opts },
                  cmd = function() vim.lsp.buf.format({async = true}) end,
                },
                {
                  desc = "LSP: Symbol info", keys = { "n", "K", opts },
                  cmd = vim.lsp.buf.hover,
                },
                {
                  desc = "LSP: Definition", keys = { "n", "gd", opts },
                  cmd = vim.lsp.buf.definition,
                },
                {
                  desc = "LSP: Declaration", keys = { "n", "gD", opts },
                  cmd = vim.lsp.buf.declaration,
                },
                {
                  desc = "LSP: Implementation", keys = { "n", "gi", opts },
                  cmd = vim.lsp.buf.implementation,
                },
                {
                  desc = "LSP: Type definition", keys = { "n", "go", opts },
                  cmd = vim.lsp.buf.type_definition,
                },
                {
                  desc = "LSP: References", keys = { "n", "gr", opts },
                  cmd = vim.lsp.buf.references,
                },
                {
                  desc = "LSP: Signature help", keys = { "n", "gs", opts },
                  cmd = vim.lsp.buf.signature_help,
                },
                {
                  desc = "LSP: Signature help", keys = { "n", "<F4>", opts },
                  cmd = vim.lsp.buf.code_action,
                }
              }, { cat = "LSP", set = binds_new, show = binds_new })
            end,
          })

          local cmp = require('cmp')
          local cmp_action = require('lsp-zero').cmp_action()

          cmp.setup({
            sources = {
              {name = 'nvim_lsp'},
            },
            snippet = {
              expand = function(args)
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

          require'lspconfig'.nixd.setup({
            settings = {
              nixd = {
                nixpkgs = {
                  expr = '(builtins.getFlake ("path:' .. os.getenv("HOME") .. '/git/nixos-config")).nixosConfigurations.' .. vim.fn.hostname() .. '.pkgs',
                },
                formatting = {
                  command = { "nixfmt" },
                },
                options = {
                  nixos = {
                    expr = '(builtins.getFlake ("path:' .. os.getenv("HOME") .. '/git/nixos-config")).nixosConfigurations.' .. vim.fn.hostname() .. '.options',
                  },
                  ['home-manager'] = {
                    expr = '(builtins.getFlake ("path:' .. os.getenv("HOME") .. '/git/nixos-config")).homeConfigurations.' .. os.getenv("USER") .. '.options',
                  },
                },
              },
            },
          })
          require'lspconfig'.pylsp.setup{}
          require'lspconfig'.pyright.setup{}
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
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = /* lua */ ''
          require'nvim-treesitter.configs'.setup {
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
            },
            incremental_selection = {
              enable = true,
            },
          }
          vim.wo.foldmethod = 'expr'
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.cmd('set foldlevel=99')
        '';
      }
    ]);

    extraLuaConfig = /* lua */ ''
      vim.lsp.inlay_hint.enable(true)
    '';
  };
}
