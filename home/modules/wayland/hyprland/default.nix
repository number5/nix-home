{
  self,
  nix-search,
  ...
}: {
  config,
  pkgs,
  lib,
  ...
}: let
  fontPkgs = with pkgs; [
    font-awesome # awesome fonts
    material-design-icons # fonts with glyphs
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    sarasa-gothic
    roboto-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  audioPkgs = with pkgs; [
    paprefs # pulseaudio preferences
    pasystray # pulseaudio systray
    pavucontrol # pulseaudio volume control
    playerctl # music player controller
    pulsemixer # pulseaudio mixer
  ];

  packages = with pkgs;
    [
      hyprsome
      brightnessctl # control laptop display brightness
      loupe # image viewer
      libnotify # notifications
      nemo # file manager
      nix-search.packages.${system}.default
      wl-clipboard # clipboard support
      wofi # app launcher
    ]
    ++ fontPkgs
    ++ audioPkgs;

in {
  imports = [
    ../../hyprlock
    ../../hyprpaper
    ../../hypridle
    ./binds.nix
    ./rules.nix
    ./settings.nix
  ];

  home = {
    inherit packages;
    stateVersion = "24.11";

    sessionVariables = {
      NIXOS_OZONE_WL = 1;
      SHELL = "${lib.getExe pkgs.zsh}";
      MOZ_ENABLE_WAYLAND = 1;
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      GDK_BACKEND = "wayland,x11";
      QT_QPA_PLATFORM = "wayland;xcb";
    };
  };

  fonts.fontconfig.enable = true;

  # e.g. for slack, signal, etc
  xdg.configFile."electron-flags.conf".text = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
  '';

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = ["hyprland"];
      };
      hyprland = {
        default = ["gtk" "hyprland"];
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;
  };

 programs.hyprland.withUWSM  = true;
  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enable = false;
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };

    plugins = {
      hyprbars = {
        bar_height = 20;
        bar_precedence_over_border = true;

        # order is right-to-left
        hyprbars-button = [
          # close
          "rgb(ffb4ab), 15, , hyprctl dispatch killactive"
          # maximize
          "rgb(b6c4ff), 15, , hyprctl dispatch fullscreen 1"
        ];
      };

      hyprexpo = {
        columns = 3;
        gap_size = 4;
        bg_col = "rgb(000000)";

        enable_gesture = true;
        gesture_distance = 300;
        gesture_positive = false;
      };
    };
    xwayland.enable = true;
  };
}
