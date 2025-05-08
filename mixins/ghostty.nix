{
  pkgs,
  config,
  inputs,
  ...
}:

let
  prefs = import ./_preferences.nix { inherit pkgs inputs; };
  # colors = prefs.themes.alacritty;
in
{
  config = {
    home-manager.users.bruce =
      { pkgs, ... }:
      {
        programs.ghostty = {
          enable = true;
          settings = {
            theme = "dark:\"Builtin Tango Dark\",light:\"Builtin Tango Light\"";
            font-family = "${prefs.font.monospace.family}";
            window-decoration = false;
            gtk-titlebar = false;
            background-opacity = "0.9";
          };
        };
      };
  };
}
