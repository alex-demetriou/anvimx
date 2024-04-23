{ pkgs }:
let
  ts-all = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  ts-parsers = pkgs.symlinkJoin {
    name = "ts-parsers";
    paths = ts-all.dependencies;
  };
in
  {
  lazyPlugin = {
    pkg = pkgs.vimPlugins.nvim-treesitter;
    lazy = false;
    config = ''
      function ()
        vim.opt.runtimepath:append("${ts-all}")
        vim.opt.runtimepath:append("${ts-parsers}")

        local configs = require("nvim-treesitter.configs")

        configs.setup({
          parser_install_dir = "${ts-parsers}",
          ensure_installed = {},
          auto_install = false,
          highlight = { enable = true },
          indent = { enable = true },
          incremental_selection = { enable = true },
        })
      end
    '';
  };

  files = {
  "queries/nix/injections.scm" = ''
    ;; extends

    (binding
      attrpath: (attrpath (identifier) @_path)
      expression: [
        (string_expression (string_fragment) @lua)
        (indented_string_expression (string_fragment) @lua)
      ]
      (#match? @_path "^extraConfigLua(Pre|Post)?$"))

    (binding
      attrpath: (attrpath (identifier) @_path)
      expression: [
        (string_expression (string_fragment) @vim)
        (indented_string_expression (string_fragment) @vim)
      ]
      (#match? @_path "^extraConfigVim(Pre|Post)?$"))
  '';
  };
  }
