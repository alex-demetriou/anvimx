{ pkgs }:
{
  lazyPlugin = {
    pkg = pkgs.vimPlugins.conform-nvim;
    opts = {
      notify_on_error = false;
      format_after_save.lsp_fallback = true;
      formatters_by_ft = {
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
      };
    };
  };

  opts.formatexpr = "v:lua.require'conform'.formatexpr()";
}
