{
  self,
  eww,
  anyrun,
  ...
}: {
  config,
  pkgs,
  lib,
  ...
}: let
  hypr-config = import ./config.nix {
    eww = eww;
    anyrun = anyrun;
    lib = lib;
    config = config;
    pkgs = pkgs;
  };
  rules = import ./rules.nix;
in {
  imports = [ rules ];
  config =
    hypr-config
    // {
      home = {
        packages = with pkgs; [
          seatd
          jaq
        ];
      };

      # enable hyprland
      wayland.windowManager.hyprland = {
        enable = true;

        # plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
        #   # hyprbars
        #   # hyprexpo
        # ];

        systemd = {
          variables = ["--all"];
          extraCommands = [
            "systemctl --user stop graphical-session.target"
            "systemctl --user start hyprland-session.target"
          ];
        };
      };
    };
}
