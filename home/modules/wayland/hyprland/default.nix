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
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "Iosevka"
      ];
    })
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
    # ../../shared
    # ../../foot
    ../../hyprlock
    ../../hyprpaper
    # ../../programs/pyprland
    # ../../programs/waybar
    ../../hypridle
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
      (builtins.readFile ./hyprland.conf)
      + ''
        bind=SUPER,P,exec,${lib.getExe pkgs.wofi} --show run --style=${./wofi.css} --term=footclient --prompt=Run
        bind=SUPER,A,exec,${gblast} save area
        bind=SUPER,S,exec,${gblast} save screen
        bind=SUPERCTRL,L,exec,${lib.getExe pkgs.hyprlock}
        # audio volume bindings
        bindel=,XF86AudioRaiseVolume,exec,${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%+
        bindel=,XF86AudioLowerVolume,exec,${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-
        bindl=,XF86AudioMute,exec,${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle

        exec-once=${lib.getExe pkgs.hyprpaper}
        exec-once=${pkgs.pyprland}/bin/pypr
        exec-once=${pkgs.blueman}/bin/blueman-applet
        exec-once=${pkgs.networkmanagerapplet}/bin/nm-applet --sm-disable --indicator
        exec-once=${lib.getExe pkgs.pasystray}
      '';
    plugins = [];
    systemd = {
      enable = true;
      variables = ["--all"];
    };
    xwayland.enable = true;
  };
}
