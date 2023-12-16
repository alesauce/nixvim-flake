{pkgs, ...}: let
  inherit (pkgs) lib;
  importExtraPlugin = file:
    import (./extra-plugins + "/${file}");

  extraPlugins =
    lib.mapAttrsToList
    (
      file: _:
        importExtraPlugin file
    )
    (builtins.readDir ./extra-plugins);
in {
  /*
     Creating a folder of submodules that I can use to define and configure plugins that
  aren't currently in nixpkgs
  */
  plugins.packer = {
    enable = true;

    plugins = extraPlugins;
  };
}
