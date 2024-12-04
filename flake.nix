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
    self,
    nixvim,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;}
    {
      systems = ["aarch64-linux" "x86_64-linux" "aarch64-darwin"];

      flake = {
        overlays.default = final: prev: {
          kotlin-language-server = prev.kotlin-language-server.overrideAttrs rec {
            version = "1.3.3";
            src = prev.fetchzip {
              url = "https://github.com/fwcd/kotlin-language-server/releases/download/${version}/server.zip";
              hash = "sha256-m0AgPJ8KgzOxHPB33pgSFe7JQxidPkhDUga56LuaDBA=";
            };
          };
        };
      };
      perSystem = {
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
        nvim = nixvim'.makeNixvimWithModule nixvimModule;
      in {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [self.overlays.default];
        };
        checks = {
          default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
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
