{inputs, ...}: {
  _file = ./default.nix;

  perSystem = {
    system,
    pkgs,
    lib,
    inputs',
    ...
  }: {
    packages = lib.mkMerge [
      {
        alejandra = inputs'.alejandra.packages.default;
      }
    ];
  };
}
