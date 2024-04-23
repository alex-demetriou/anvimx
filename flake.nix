{
  description = "my nixvim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell.url = "github:numtide/devshell";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.devshell.flakeModule ];

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, system, ... }:
        let
          anvim = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
            inherit pkgs;
            module = import ./module;
          };
        in
        {
          formatter = pkgs.nixfmt-rfc-style;
          packages.default = anvim;

          devshells.default = {
            packages = [ anvim ];
          };
        };
    };
}
