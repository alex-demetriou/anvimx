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
    pkgs.nixd
    pkgs.stylua
    pkgs.nixfmt-rfc-style
    pkgs.lua-language-server
    pkgs.omnisharp-roslyn
  ];

  config.enableMan = false; # TODO: re-enable when broken aarch64-linux dependency is fixed
}
