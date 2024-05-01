{ pkgs }:
{
  pkg = pkgs.vimPlugins.typescript-tools-nvim;
  dependencies = [
    pkgs.vimPlugins.plenary-nvim
    pkgs.vimPlugins.nvim-lspconfig
    pkgs.vimPlugins.cmp-nvim-lsp
  ];
  config = # lua
    ''
      function()
      	require("typescript-tools").setup({
      		capabilities = require("cmp_nvim_lsp").default_capabilities(),
      	})
      end
    '';
}
