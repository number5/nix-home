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
      brightnessctl # control laptop display brightness
      loupe # image viewer
      libnotify # notifications
      nemo # file manager
      nix-search.packages.${system}.default
      wl-clipboard # clipboard support
      wofi # app launcher
      xwaylandvideobridge # screensharing bridge
    ]
    ++ fontPkgs
    ++ audioPkgs;

  gblast = lib.getExe pkgs.grimblast;
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
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

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig =
      ''
        # debug
        
        debug:disable_scale_checks=true

        # bindings 
        bind=SUPER,P,exec,${lib.getExe pkgs.wofi} --show run --style=${./wofi.css} --term=footclient --prompt=Run
        bind=SUPERCTRL,L,exec,${lib.getExe pkgs.hyprlock}


        exec-once=~/.config/hypr/start-way-displays.sh
        exec-once=${lib.getExe pkgs.hyprpaper}
        exec-once=${pkgs.pyprland}/bin/pypr
        exec-once=${pkgs.blueman}/bin/blueman-applet
        exec-once=${pkgs.networkmanagerapplet}/bin/nm-applet --sm-disable --indicator
        exec-once=${lib.getExe pkgs.pasystray}
      '';

    systemd = {
      enable = false;
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
    plugins = [];
    xwayland.enable = true;
  };
}
