{ pkgs }:
{

  pkg = pkgs.vimPlugins.nvim-cmp;
  event = [
    "InsertEnter"
    "CmdlineEnter"
  ];
  dependencies = [
    pkgs.vimPlugins.cmp-buffer
    pkgs.vimPlugins.cmp-path
    pkgs.vimPlugins.cmp-cmdline
    pkgs.vimPlugins.cmp-nvim-lsp-signature-help
    pkgs.vimPlugins.cmp-nvim-lua
    pkgs.vimPlugins.luasnip
    pkgs.vimPlugins.cmp_luasnip
  ];
  config = # lua
    ''
      function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        require("luasnip/loaders/from_vscode").lazy_load()

        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          sources = cmp.config.sources({
            { name = "nvim_lsp_signature_help" },
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "luasnip" },
          }, {
            { name = "buffer" },
            { name = "path" },
          }),
          mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          }),
        })

        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            { name = "cmdline" },
          }),
        })
      end
    '';
}
