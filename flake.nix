{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { nixpkgs, nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "aarch64-linux" "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];

      perSystem = { system, pkgs, self', ... }:
        let
          nixvim' = nixvim.legacyPackages.${system};
          nvim = nixvim'.makeNixvimWithModule {
            inherit pkgs;
            module = ./config/full.nix;
          };
        in {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = builtins.attrValues {
              default = import ./overlay {
                inherit inputs;
              };
            };
          };

          checks = {
            default = pkgs.nixvimLib.check.mkTestDerivationFromNvim {
              inherit nvim;
              name = "A nixvim configuration";
            };
            pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
              src = ./.;
              hooks = {
                statix.enable = true;
                alejandra.enable = true;
              };
            };
          };

          formatter = pkgs.alejandra;

          packages = rec {
            default = full;
            full = nvim;
          };

          devShells = {
            default = with pkgs;
              mkShell { inherit (self'.checks.pre-commit-check) shellHook; };
          };
        };
    };
}
