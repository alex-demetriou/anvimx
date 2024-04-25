{ pkgs }:
{
  lazyPlugin = {
    pkg = pkgs.vimPlugins.conform-nvim;
    opts = {
      notify_on_error = true;
      format_after_save.lsp_fallback = "always";
      formatters_by_ft = {
        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        _ = [ "trim_whitespace" ];
        "*" = [
          "injected"
          "codespell"
        ];
      };
    };
    keys = {
      __raw = # lua
        ''
          {{
          	"<leader>f",
          	function()
          		require("conform").format({
          			async = true,
          			lsp_fallback = true,
          		})
          	end
          }}
        '';
    };
    dependencies = [ pkgs.codespell ];
  };

  opts.formatexpr = "v:lua.require'conform'.formatexpr()";
}
