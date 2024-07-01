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

  home = let
        cursor = {
          package = pkgs.catppuccin-cursors.macchiatoTeal;
          name = "catppuccin-macchiato-teal-cursors";
          size = 24;
        };
      in {
    packages = let
      p = pkgs;
      s = self';
    in [
      p.exercism
      p.lefthook
    ];


    pointerCursor = {
          gtk.enable = true;
          name = cursor.name;
          package = cursor.package;
          size = cursor.size;
          x11 = {
            defaultCursor = cursor.name;
            enable = true;
          };
    };

    stateVersion = "24.05";
  };
}
