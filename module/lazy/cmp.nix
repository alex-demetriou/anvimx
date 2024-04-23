{ pkgs }:
{

  pkg = pkgs.vimPlugins.nvim-cmp;
  event = [
    "BufReadPost"
    "BufNewFile"
  ];
  dependencies = [
    pkgs.vimPlugins.cmp-buffer
    pkgs.vimPlugins.cmp-path
    pkgs.vimPlugins.cmp-cmdline
    pkgs.vimPlugins.cmp-nvim-lua
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
