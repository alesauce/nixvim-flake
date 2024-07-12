{
  description = "Alesauce's Neovim configuration, modeled via Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    nix-fast-build = {
      url = "github:Mic92/nix-fast-build";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixvim,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-linux" "x86_64-linux" "aarch64-darwin"];

      perSystem = {
        system,
        pkgs,
        self',
        ...
      }: let
        nixvim' = nixvim.legacyPackages.${system};
        nixvimModule = {
          inherit pkgs;
          module = ./config/full.nix;
        };
        nvim = nixvim'.makeNixvimWithModule nixvimModule;
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
          default = pkgs.nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              statix.enable = true;
              alejandra.enable = true;
              actionlint.enable = true;
              deadnix = {
                enable = true;
                settings = {
                  noLambdaArg = true;
                  noLambdaPatternNames = true;
                };
              };
            };
          };
        };

        formatter = pkgs.alejandra;

        packages = {
          inherit (pkgs) jq nix-fast-build;
          default = nvim;
        };

        devShells = {
          default = with pkgs;
            mkShell {
              inherit (self'.checks.pre-commit-check) shellHook;
              nativeBuildInputs = [jq];
            };
        };
      };
    };
}
