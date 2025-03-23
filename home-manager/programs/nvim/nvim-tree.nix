{ pkgs, lib, ... }:
{
  programs.neovim = {
    plugins = lib.mkAfter ( with pkgs.vimPlugins; [
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = /* lua */ ''
          local tree_actions = {
            {
              name = "Create node",
              handler = require("nvim-tree.api").fs.create,
            },
            {
              name = "Remove node",
              handler = require("nvim-tree.api").fs.remove,
            },
            {
              name = "Trash node",
              handler = require("nvim-tree.api").fs.trash,
            },
            {
              name = "Rename node",
              handler = require("nvim-tree.api").fs.rename,
            },
            {
              name = "Fully rename node",
              handler = require("nvim-tree.api").fs.rename_sub,
            },
            {
              name = "Copy",
              handler = require("nvim-tree.api").fs.copy.node,
            },
          }

          local function tree_actions_menu(node)
            local entry_maker = function(menu_item)
              return {
                value = menu_item,
                ordinal = menu_item.name,
                display = menu_item.name,
              }
            end
            local finder = require("telescope.finders").new_table({
              results = tree_actions,
              entry_maker = entry_maker,
            })
            local sorter = require("telescope.sorters").get_generic_fuzzy_sorter()
            local default_options = {
              finder = finder,
              sorter = sorter,
              attach_mappings = function(prompt_buffer_number)
                local actions = require("telescope.actions")
                actions.select_default:replace(function()
                        local state = require("telescope.actions.state")
                        local selection = state.get_selected_entry()
                        actions.close(prompt_buffer_number)
                        selection.value.handler(node)
                end)
                actions.add_selection:replace(function() end)
                actions.remove_selection:replace(function() end)
                actions.toggle_selection:replace(function() end)
                actions.select_all:replace(function() end)
                actions.drop_all:replace(function() end)
                actions.toggle_all:replace(function() end)
                return true
              end,
            }
            require("telescope.pickers").new({ prompt_title = "Tree menu" }, default_options):find()
          end

          local function my_nvim_tree_attach(bufnr)
              local api = require "nvim-tree.api"
              local function opts(desc)
                  return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end
              api.config.mappings.default_on_attach(bufnr)
              vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
              vim.keymap.set('n', '<C-R>', api.tree.reload, opts('Reload'))
              vim.keymap.set('n', '<F2>', api.fs.rename, opts('Rename'))
              vim.keymap.set("n", "<C-P>", tree_actions_menu, opts('Tree menu'))
            end

          require('nvim-tree').setup({
            on_attach = my_nvim_tree_attach,
          })

          local nt_api = require "nvim-tree.api"

          nt_api.events.subscribe(nt_api.events.Event.TreeOpen, function()
            local tree_winid = nt_api.tree.winid()
            if tree_winid ~= nil then
              vim.api.nvim_set_option_value('statusline', '%t', {win = tree_winid})
            end
          end)
        '';
      }
    ]);

    extraConfig = /* vim */ ''
      function! NvimTreeToggleAll()
        let current_tab = tabpagenr()
        if g:nvim_tree_open
          tabdo NvimTreeClose
          let g:nvim_tree_open = 0
        else
          tabdo NvimTreeOpen
          let g:nvim_tree_open = 1
        endif
        execute 'tabnext' current_tab
      endfunction
      let g:nvim_tree_open = 0
      if isdirectory(argv(0))
        let g:nvim_tree_open = 1
      endif
      nnoremap <C-f> :call NvimTreeToggleAll()<CR>
    '';
  };
}
