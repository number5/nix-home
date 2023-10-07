{inputs, ...}: {
  _file = ./default.nix;

  perSystem = {
    system,
    pkgs,
    lib,
    inputs',
    ...
  }: let
    upkgs = inputs'.nixpkgs-unstable.legacyPackages;
  in {
    packages = lib.mkMerge [
      {
        alejandra = inputs'.alejandra.packages.default;
      }
    ];
  };
}
