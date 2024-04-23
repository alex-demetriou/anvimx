{ pkgs }:
let
  ts-root = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    # programming
    p.bash
    p.c_sharp
    p.javascript
    p.lua
    p.luap
    p.python
    p.scheme
    p.tsx
    p.typescript

    # info
    p.comment
    p.git_rebase
    p.gitattributes
    p.jsdoc
    p.luadoc
    p.vimdoc

    # config
    p.dockerfile
    p.git_config
    p.gitignore
    p.gpg
    p.helm
    p.hyprlang
    p.make
    p.nix
    p.properties
    p.requirements
    p.ssh_config
    p.terraform
    p.tmux
    p.vim

    # markup
    p.html
    p.latex
    p.markdown
    p.markdown_inline
    p.mermaid
    p.norg
    p.toml
    p.yaml

    # data
    p.csv
    p.graphql
    p.http
    p.json
    p.promql
    p.regex

    # util
    p.diff
    p.passwd
    p.printf
    p.query
    p.readline
  ]);
  ts-parsers = pkgs.symlinkJoin {
    name = "ts-parsers";
    paths = ts-root.dependencies;
  };
in
{
  pkg = pkgs.vimPlugins.nvim-treesitter;
  lazy = false;
  config = ''
    function ()
      vim.opt.runtimepath:append("${ts-root}")
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
}
