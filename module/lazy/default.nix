{ pkgs, ... }:
let
  comment = import ./comment.nix { inherit pkgs; };
  treesitter = import ./treesitter.nix { inherit pkgs; };
  conform = import ./conform.nix { inherit pkgs; };
  gitsigns = import ./gitsigns.nix { inherit pkgs; };
  lspconfig = import ./lspconfig.nix { inherit pkgs; };
  telescope = import ./telescope.nix { inherit pkgs; };
  which-key = import ./which-key.nix { inherit pkgs; };
in
{
  plugins.lazy = {
    enable = true;
    plugins = [
      comment
      treesitter.lazyPlugin
      conform.lazyPlugin
      gitsigns
    ];
  };

  extraFiles = treesitter.files;
  inherit (conform) opts;
}
