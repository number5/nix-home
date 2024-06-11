{
  unstable,
  self,
  ...
}: {
  config,
  pkgs,
  lib,
  ...
}: let
  self' = self.packages.${pkgs.system};
in {
  _file = ./default.nix;

  imports = [
    ./starship.nix
  ];

  home = {
    packages = let
      p = pkgs;
      s = self';
    in [
      p.exercism
      p.lefthook
    ];

    stateVersion = "24.05";
  };
}
