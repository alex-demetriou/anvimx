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
    pkgs.vimPlugins.cmp-nvim-lua
    pkgs.vimPlugins.lspkind-nvim
  ];
  config = # lua
    ''
      function()
        local cmp = require('cmp')
        cmp.setup({
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
          }, {
            { name = "buffer" },
            { name = "path" },
          }),
          mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete({}),
            ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          }),
          window = {
            completion = {
              winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
              col_offset = -3,
              side_padding = 0,
            },
          },
          formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
              local kind = require("lspkind")
                .cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
              local strings = vim.split(kind.kind, "%s", { trimempty = true })
              kind.kind = " " .. (strings[1] or "") .. " "
              kind.menu = "    (" .. (strings[2] or "") .. ")"

              return kind
            end,
          },
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
