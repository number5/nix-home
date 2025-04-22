{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.xserver.dpi = 144;
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF
        Xft.dpi: 144
        Xft.autohint: 0
        Xft.lcdfilter:  lcddefault
        Xft.hintstyle:  hintfull
        Xft.hinting: 1
        Xft.antialias: 1
        Xft.rgba: rgb
        Xcursor.theme: Adwaita
        Xcursor.size: 64
    EOF
  '';
}
