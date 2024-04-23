{
  description = "my nixvim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, system, ... }:
        let
          nixvim = inputs.nixvim.legacyPackages.${system};
        in
        {
          formatter = pkgs.nixfmt-rfc-style;
          packages.default = nixvim.makeNixvimWithModule {
            inherit pkgs;
            module = import ./module;
          };
        };
    };
}
