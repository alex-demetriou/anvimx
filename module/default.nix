{ pkgs, ... }:
{
  imports = [
    ./set.nix
    ./autocmd.nix
    ./keymap.nix
    ./appearance.nix
    ./lazy
  ];

  config.extraPackages = [
    pkgs.fzf
    pkgs.gopls
    pkgs.lua-language-server
    pkgs.nixd
    pkgs.nixfmt-rfc-style
    pkgs.nodejs
    pkgs.omnisharp-roslyn
    pkgs.stylua
    pkgs.tree-sitter
  ];

  config.enableMan = false; # TODO: re-enable when broken aarch64-linux dependency is fixed
}
