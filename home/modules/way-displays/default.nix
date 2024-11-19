_: {pkgs, ...}: {
  home.packages = [pkgs.way-displays];

  home.file.".config/hypr/start-way-displays.sh" = {
    source = ./start-way-displays.sh;
    executable = true;
  };
}
