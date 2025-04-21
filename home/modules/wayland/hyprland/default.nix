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
    stateVersion = "25.05";

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      SHELL = "${lib.getExe pkgs.zsh}";
      MOZ_ENABLE_WAYLAND = "1";
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

    systemd.enable = false;

    plugins = [];
    xwayland.enable = true;
  };
}
