{
  self,
  ...
}: {
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.eww;
in {
  options.modules.eww = {enable = lib.mkEnableOption "eww";};

  config = lib.mkIf cfg.enable {
    # theres no programs.eww.enable here because eww looks for files in .config
    # thats why we have all the home.files

    # eww package
    home.packages = [
      pkgs.eww
      pkgs.pamixer
      pkgs.brightnessctl
      (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})
    ];

    # configuration
    home.file.".config/eww/eww.scss".source = ./eww.scss;
    home.file.".config/eww/eww.yuck".source = ./eww.yuck;

    # scripts
    home.file.".config/eww/scripts/battery.sh" = {
      source = ./scripts/battery.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/wifi.sh" = {
      source = ./scripts/wifi.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/brightness.sh" = {
      source = ./scripts/brightness.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/workspaces.sh" = {
      source = ./scripts/workspaces.sh;
      executable = true;
    };

    home.file.".config/eww/scripts/workspaces.lua" = {
      source = ./scripts/workspaces.lua;
      executable = true;
    };
  };
}
