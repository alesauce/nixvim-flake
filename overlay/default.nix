{inputs, ...}: let
  additions = final: _prev:
    import ../pkgs {
      inherit inputs;
      pkgs = final;
    };
in
  inputs.nixpkgs.lib.composeManyExtensions [additions]
