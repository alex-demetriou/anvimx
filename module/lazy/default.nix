{ pkgs, ... }:
let
  comment = import ./comment.nix { inherit pkgs; };
  treesitter = import ./treesitter.nix { inherit pkgs; };
  conform = import ./conform.nix { inherit pkgs; };
  gitsigns = import ./gitsigns.nix { inherit pkgs; };
  lspconfig = import ./lspconfig.nix { inherit pkgs; };
  telescope = import ./telescope.nix { inherit pkgs; };
  cmp = import ./cmp.nix { inherit pkgs; };
  which-key = import ./which-key.nix { inherit pkgs; };
in
{
  plugins.lazy = {
    enable = true;
    plugins = [
      comment
      treesitter
      conform.lazyPlugin
      gitsigns
      telescope
      lspconfig
      cmp
    ];
  };

  inherit (conform) opts;
}
