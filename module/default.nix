{ pkgs, ... }:
{
  imports = [
    ./set.nix
    ./autocmd.nix
    ./keymap.nix
    ./appearance.nix
    ./lazy
  ];
  config.enableMan = false; # TODO: re-enable when weird aarch64-linux requirement is fixed
  config.extraPackages = [
    pkgs.nixd
    pkgs.stylua
    pkgs.nixfmt-rfc-style
    pkgs.lua-language-server
    pkgs.omnisharp-roslyn
  ];
}
