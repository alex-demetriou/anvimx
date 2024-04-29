{ pkgs }:
{
  pkg = pkgs.vimPlugins.nvim-lspconfig;
  event = [
    "BufReadPost"
    "BufNewFile"
  ];
  dependencies = [
    pkgs.vimPlugins.omnisharp-extended-lsp-nvim
    pkgs.vimPlugins.cmp-nvim-lsp
  ];
  config = # lua
    ''
      function()
        local lsp = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        lsp.nixd.setup({
          capabilities = capabilities,
          settings = {
            nixd = {
              nixpkgs = {
                expr = "import (builtins.getFlake \"/home/nixos/repo/anix\").inputs.nixpkgs { }"
              },
              options = {
                anvimx = {
                  expr = "(builtins.getFlake \"/home/nixos/repo/anvimx\").debug.options"
                },
              },
            },
          },
        })
        lsp.lua_ls.setup({ capabilities = capabilities })

        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
      end
    '';
}
