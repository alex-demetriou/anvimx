{ pkgs, ... }:
let
  cmp = import ./cmp.nix { inherit pkgs; };
  comment = import ./comment.nix { inherit pkgs; };
  conform = import ./conform.nix { inherit pkgs; };
  fzf-lua = import ./fzf-lua.nix { inherit pkgs; };
  gitsigns = import ./gitsigns.nix { inherit pkgs; };
  guess-indent = import ./guess-indent.nix { inherit pkgs; };
  lspconfig = import ./lspconfig.nix { inherit pkgs; };
  neodev = import ./neodev.nix { inherit pkgs; };
  treesitter = import ./treesitter.nix { inherit pkgs; };
in
{
  plugins.lazy = {
    enable = true;
    plugins = [
      cmp
      comment
      conform.lazyPlugin
      fzf-lua
      gitsigns
      guess-indent
      lspconfig
      neodev
      treesitter
    ];
  };

  inherit (conform) opts;
}
