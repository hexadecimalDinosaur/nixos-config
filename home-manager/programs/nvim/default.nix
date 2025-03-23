{ pkgs, ... }:
{
  imports = [
    ./ui.nix
    ./projects.nix
    ./telescope.nix
    ./lsp.nix
    ./nvim-tree.nix
    ./neovide.nix
  ];

  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;

      extraLuaConfig = /* lua */ ''
        vim.keymap.set("n", "<C-t>", ":tabnew<CR>")
      '';
      extraConfig = /* vim */ ''
        au BufRead,BufNewFile *.hujson set filetype=json5
      '';

      plugins = with pkgs.vimPlugins; [
        zoxide-vim
        vim-gitgutter
        vim-sleuth
        direnv-vim
        vim-nixhash
        # vimtex
        codi-vim
        neorepl-nvim
        {
          plugin = zeavim-vim;
          type = "viml";
          config = /* vim */ ''
            let g:zv_docsets_dir = $HOME . "/.local/share/Zeal/Zeal/docsets"
            let g:zv_disable_mapping = 1
            let g:zv_file_types = {
              \ 'nix'    : 'nix,nixpkgs,nixos,home-manager',
              \ 'python' : 'python3,requests',
              \ 'html'   : 'html,css',
              \ 'css'    : 'css',
              \ 'go'     : 'go',
            \ }
            let g:zv_zeal_executable = '${pkgs.zeal.out}/bin/zeal'
          '';
        }
        # magma-nvim
        {
          plugin = whitespace-nvim;
          type = "lua";
          config = /* lua */ ''
            require('whitespace-nvim').setup({
              highlight = 'DiffDelete',
              ignored_filetypes = {
                'TelescopePrompt',
                'TelescopePreviewerLoaded',
                'TelescopeResults',
                'Trouble',
                'help',
                'dashboard',
              },
              ignore_terminal = true,
              return_cursor = true,
            })
            vim.keymap.set('n', '<Leader>t', require('whitespace-nvim').trim)
          '';
        }
      ];
    };

    zsh.shellAliases.codi = /* sh */ ''
      nvim -c \
        "let g:startify_disable_at_vimenter = 1 |\
        set bt=nofile ls=0 noru nonu nornu |\
        hi ColorColumn ctermbg=NONE |\
        hi VertSplit ctermbg=NONE |\
        hi NonText ctermfg=0 |\
        Codi python"
    '';
  };
}
