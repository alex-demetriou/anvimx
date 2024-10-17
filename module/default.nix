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
    pkgs.tree-sitter
    pkgs.nodejs
    pkgs.nixd
    pkgs.biome
    pkgs.stylua
    pkgs.nixfmt-rfc-style
    pkgs.lua-language-server
    pkgs.csharp-ls
    pkgs.omnisharp-roslyn
    pkgs.dotnet-sdk_8
    pkgs.dotnet-sdk_6
    pkgs.dotnet-runtime_8
    pkgs.dotnet-runtime_6
    pkgs.fzf
  ];

  config.enableMan = false; # TODO: re-enable when broken aarch64-linux dependency is fixed
}
