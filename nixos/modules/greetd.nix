{ self, ... }:
{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.dconf.enable = true;

  # tty service config
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  programs.hyprland = {
    enable = true;
  };
  programs.uwsm = {
    enable = true;
    waylandCompositors.hyprland = {
      binPath = "/run/current-system/sw/bin/Hyprland";
      prettyName = "Hyprland";
      comment = "Hyprland managed by UWSM";
    };
  };

  services = {
    # Bluetooth manager
    blueman.enable = true;

    # GTK theme config
    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };

    # User's credentials manager
    gnome.gnome-keyring.enable = true;

    # greetd display manager
    greetd =
      let
        session = {
          command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop";
          user = "bruce";
        };
      in
      {
        enable = true;
        settings = {
          terminal.vt = 1;
          default_session = session;
          initial_session = session;
        };
      };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # Prerequisite for screensharing
      wireplumber.enable = true;
    };

    # Allows Hyprland to run without root privileges
    seatd.enable = true;
  };
}
