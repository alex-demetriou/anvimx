{ pkgs }:
{
  pkg = pkgs.vimPlugins.fzf-lua;
  dependencies = [
    pkgs.fzf
    pkgs.fd
    pkgs.ripgrep
    pkgs.delta
    pkgs.vimPlugins.nvim-dap
    pkgs.vimPlugins.nvim-web-devicons
  ];

  config = # lua
    ''
      function()
        local fzf_lua = require("fzf-lua")
        fzf_lua.setup({
            winopts = {
              preview = {
                flip_columns = 200;
                delay = 0;
              },
            },
        })

        vim.keymap.set('n', '<leader>sh', fzf_lua.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sk', fzf_lua.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sf', fzf_lua.files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>ss', fzf_lua.builtin, { desc = '[S]earch [S]elect Fzf' })
        vim.keymap.set('n', '<leader>sw', fzf_lua.grep_cword, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sG', fzf_lua.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', fzf_lua.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', fzf_lua.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', fzf_lua.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', fzf_lua.buffers, { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>gf', fzf_lua.git_files, { desc = 'Search [G]it [F]iles' })
        vim.keymap.set('n', '<leader>gs', fzf_lua.git_status, { desc = 'Show [G]it [S]tatus' })
      end
    '';
}
