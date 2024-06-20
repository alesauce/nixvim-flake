{inputs, ...}: let
  additions = final: _prev:
    import ../pkgs {
      inherit inputs;
      pkgs = final;
    };
in
  inputs.nixpkgs.lib.composeManyExtensions [
    additions
    (final: prev: {
      inherit (inputs.nix-fast-build.packages.${final.stdenv.hostPlatform.system}) nix-fast-build;
    })
  ]
