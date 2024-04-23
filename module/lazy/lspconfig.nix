{ pkgs }:
{
  lspconfig = {
    pkg = pkgs.vimPackages.nvim-lspconfig;
    event = [
      "BufReadPost"
      "BufNewFile"
    ];
    dependencies = [
      {
        pkg = pkgs.vimPackages.nvim-cmp;
        opts.__empty = null;
      }
      {
        pkg = pkgs.vimPackages.cmp-nvim-lsp;
        opts.__empty = null;
      }
      {
        pkg = pkgs.vimPackages.neodev-nvim;
        opts.__empty = null;
      }
      {
        pkg = pkgs.omnisharp-extended-lsp-nvim;
        opts.__empty = null;
      }
    ];
    config = ''
      function()
        local lsp = require('lspconfig')
        local cmp = require('cmp')
        local cmp_lsp = require('cmp_nvim_lsp')
        local capabilities = cmp_lsp.default_capabilities()
        local neodev = require('neodev')

        neodev.setup({
          override = function(root_dir, library)
            if root_dir:find("/etc/nixos", 1, true) == 1 then
              library.enabled = true
              library.plugins = true
            end
          end,
        })

        cmp.setup({
            sources = {{name = 'nvim_lsp'}}
            })

        lsp.nixd.setup({ capabilities = capabilities, })

        lsp.lua_ls.setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {globals = { 'vim' }},
              completion = {callSnippet = 'Replace'},
              workspace = {
                library = {
                  [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                  [vim.fn.stdpath('config') .. '/lua'] = true,
                },
              },
            },
          },
        })


        -- begin omnisharp-extended-lsp --
        local ose = require('omnisharp_extended')

        vim.keymap.set('n', '<leader>D', ose.lsp_type_definition)
        vim.keymap.set('n', 'gd', ose.lsp_definition)
        vim.keymap.set('n', 'gr', ose.lsp_references)
        vim.keymap.set('n', 'gi', ose.lsp_implementation)
        vim.print('testing 123')

        lsp.omnisharp.setup({
          cmd = { "${pkgs.omnisharp-roslyn}/bin/OmniSharp" },
          on_attach = on_attach,
          capabilities = capabilities,

          root_dir = function(fname)
            local primary = lsp.util.root_pattern("*.sln")(fname)
            local fallback = lsp.util.root_pattern("*.csproj")(fname)
            return primary or fallback
          end,
          analyze_open_documents_only = true,
          organize_imports_on_format = true,
          enable_ms_build_load_projects_on_demand = true,
        })
      -- end omnisharp-extended-lsp --

        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
      end
    '';
  };
}
