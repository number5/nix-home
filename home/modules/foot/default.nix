_: {pkgs, ...}: let
  fontSize = "14";
in {
  # lightweight wayland terminal emulator
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        shell = "${pkgs.zsh}/bin/zsh";
        font = "JetBrainsMono Nerdfont:size=${fontSize}";
        pad = "12x12";
        dpi-aware = "yes";
        selection-target = "both";
      };
      colors = {
        alpha = 0.5;
      };
    };
  };
}
