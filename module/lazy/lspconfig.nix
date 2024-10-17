{ pkgs }:
{
  pkg = pkgs.vimPlugins.nvim-lspconfig;
  event = [
    "BufReadPost"
    "BufNewFile"
  ];
  dependencies = [
    pkgs.vimPlugins.cmp-nvim-lsp
    pkgs.vimPlugins.csharpls-extended-lsp-nvim
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
        -- lsp.biome.setup({
        --   root_dir = function(fname)
        --     return lsp.util.root_pattern("biome.json", "biome.jsonc")(fname)
        --       or lsp.util.find_package_json_ancestor(fname)
        --       or lsp.util.find_node_modules_ancestor(fname)
        --       or lsp.util.find_git_ancestor(fname)
        --   end,
        -- })
        -- lsp.omnisharp.setup({
        --   capabilities = capabilities,
        --   cmd = {"/nix/store/nnr260k16kciq5ix95bs6nbgg7yvcxb4-omnisharp-roslyn-1.39.11/lib/omnisharp-roslyn/OmniSharp"}
        -- })
        lsp.csharp_ls.setup({
          capabilities = capabilities,
          handlers = {
            ["textDocument/definition"] = require('csharpls_extended').handler,
            ["textDocument/typeDefinition"] = require('csharpls_extended').handler,
          },
        })

        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
        vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references)

        -- vim.keymap.set('n', 'K', vim.lsp.buf.hover)
        -- vim.keymap.set('n', '<C-K>', vim.lsp.buf.signature_help)

        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
      end
    '';
}
