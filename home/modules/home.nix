{
  self,
  hyprland-contrib,
  ...
}: {
  config,
  pkgs,
  lib,
  ...
}: {
  _file = ./default.nix;

  imports = [
    ./starship.nix
  ];

  home = let
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Amber";
      # package = pkgs.catppuccin-cursors.macchiatoTeal;
      # name = "catppuccin-macchiato-teal-cursors";
      size = 24;
    };
  in {
    packages = [
      pkgs.exercism
      pkgs.lefthook
      hyprland-contrib.packages.${pkgs.system}.grimblast
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

    stateVersion = "24.11";
  };
}
