{ config, ib, pkgs, ... }:

let
  inherit (config.lib.my) getScript;
in
{
  i3.binaries = rec {
    # Things directly referenced in the config file
    terminal = "${config.my.defaults.terminal} --working-directory ${config.home.homeDirectory}";
    floating-term = "${terminal} --class='floating-term'";
    explorer = "${config.my.defaults.file-explorer}";
    browser = firefox;
    browser-private = "${browser} --private-window";
    browser-work-profile = "${browser} -P job";
    audiocontrol = pavucontrol;
    launcher = rofi;
    # logout = "${pkgs.gnome.gnome-session}/bin/gnome-session-quit";
    locker = pkgs.writeShellScript "locker" ''
       ${pkgs.lightlocker}/bin/light-locker-command -l
    '';
    screenshot = "${getScript "screenshot.sh"}";
    volume = "${getScript "volume.sh"}";


    light-locker = pkgs.writeShellScript "lockscreen" ''
      ${pkgs.lightlocker}/bin/light-locker --idle-hint --lock-on-suspend --lock-after-screensaver=5 --late-locking
    '';

    # Things used by the default commands above (or directly)
    wezterm = "${pkgs.wezterm}/bin/wezterm";
    brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
    rofi = "${pkgs.rofi}/bin/rofi";
    firefox = "${pkgs.firefox}/bin/firefox";
    pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
    # i3 and Sway don't parse quotes correctly so the commas in the command below
    # are parsed as i3/sway command separators.
    # The solution is to use a wrapper script
    playerctl = pkgs.writeShellScript "playerctl" ''
      ${pkgs.playerctl}/bin/playerctl --player=spotify,mpv,firefox "$@"
    '';
    element-desktop = "${pkgs.element-desktop}/bin/element-desktop";
    spotify = "${pkgs.spotify}/bin/spotify";
    unclutter = "${pkgs.unclutter-xfixes}/bin/unclutter --exclude-root";

    startX11SessionTarget = pkgs.writeShellScript "start-x11-session-target" ''
      ${pkgs.dbus}/bin/dbus-update-activation-environment DISPLAY XDG_SESSION_TYPE XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP
      systemctl --user import-environment DISPLAY XDG_SESSION_TYPE XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP
      systemctl --user start x11-session.target
    '';

    # The ~/.background-image should automatically be picked up by NixOS
    # but it's not the case for whatever reason.
    wallpaper = pkgs.writeShellScript "i3-wallpaper" ''
      ${pkgs.feh}/bin/feh ~/Pictures/Wallpapers/* --recursive --randomize --bg-fill
    '';
  };
}
