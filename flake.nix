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

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-github-actions = {
      url = "github:nix-community/nix-github-actions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixvim,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} (
      {lib, ...}: let
        githubPlatforms = {
          "aarch64-linux" = "ubuntu-24.04-arm";
          "x86_64-linux" = "ubuntu-latest";
          "aarch64-darwin" = "macos-latest";
        };
      in {
        systems = lib.attrNames githubPlatforms;

        imports = [
          inputs.git-hooks.flakeModule
        ];

        flake = {
          overlays.default = final: prev: {
            alesauce-nixvim = self.packages.${final.stdenv.hostPlatform.system}.neovim;
          };
          githubActions = let
            githubSystems = lib.attrNames githubPlatforms;
            ciPkgs = ["neovim"];
            checkDrvs = lib.getAttrs githubSystems self.checks;
            pkgDrvs = lib.genAttrs githubSystems (
              system: lib.genAttrs ciPkgs (pkg: self.packages.${system}.${pkg})
            );
          in
            inputs.nix-github-actions.lib.mkGithubMatrix {
              checks = lib.recursiveUpdate checkDrvs pkgDrvs;
              platforms = githubPlatforms;
            };
        };

        perSystem = {
          config,
          system,
          pkgs,
          self',
          ...
        }: let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            module = import ./config/full.nix;
          };
        in {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
          };
          checks.nixvim = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          pre-commit = {
            check.enable = true;
            settings = {
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

          packages = rec {
            inherit (pkgs) jq nix-fast-build;
            default = neovim;
            neovim = nixvim'.makeNixvimWithModule nixvimModule;
          };

          devShells = {
            default = with pkgs;
              mkShell {
                name = "nixvim-flake";
                nativeBuildInputs = [jq];
                shellHook = ''
                  ${config.pre-commit.installationScript}
                '';
              };
          };
        };
      }
    );
}
