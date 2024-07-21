{
  config,
  lib,
  pkgs,
  eww,
  anyrun,
  ...
}: let
  pointer = config.home.pointerCursor;
  anyrun-with-all-plugins = anyrun.packages.${pkgs.system}.anyrun-with-all-plugins;
  eww-bin = eww.packages.${pkgs.system}.eww;

  toggle = program: service: let
    prog = builtins.substring 0 14 program;
    runserv = lib.optionalString service "run-as-service";
  in "pkill ${prog} || ${runserv} ${program}";
in {
  wayland.windowManager.hyprland = {
    settings = {
      "$MOD" = "SUPER";
      env = [
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "HYPRCURSOR_SIZE,24"
      ];
      exec-once = [
        "hyprctl setcursor ${pointer.name} ${toString pointer.size}"
        "systemctl --user start clight"
        "hyprlock"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"

        "${eww-bin}/bin/eww daemon"
        "${eww-bin}/bin/eww open bar"
      ];
      xwayland.force_zero_scaling = true;
      input = {
        kb_layout = "us";
        follow_mouse = 2;
        sensitivity = 0;
        force_no_accel = 1;
        accel_profile = "flat";
        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
        };
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_use_r = true;
      };
      cursor = {
        no_warps = true;
      };
      misc = {
        disable_autoreload = true;
        animate_mouse_windowdragging = false;
        vrr = 1;
        no_direct_scanout = false;
        vfr = true;
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        initial_workspace_tracking = false;
      };
      general = {
        monitor = [
          # "DP-1,1366x768@60,0x0,1"
          #"eDP-1, preferred, auto, 1.0"
          ",preferred,auto,auto"
        ];
        gaps_in = 5;
        gaps_out = 5;
        border_size = 1;
        # "col.active_border" = "rgb(${c.on_primary})";
        # "col.inactive_border" = "rgb(${c.primary});";
        "no_border_on_floating" = false;
        layout = "dwindle";
      };
      decoration = {
        rounding = 1;
        blur = {
          enabled = true;
          size = 10;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          noise = "0.1";
          contrast = "1.0";
          brightness = "1.0";
          xray = true;
          vibrancy = "0.5";
          vibrancy_darkness = "0.1";
          popups = true;
          popups_ignorealpha = "0.2";
        };
        fullscreen_opacity = 1;
        drop_shadow = true;
        shadow_ignore_window = true;
        shadow_offset = "0 8";
        shadow_range = 50;
        shadow_render_power = 3;
        "col.shadow" = "rgba(00000055)";
        blurls = ["lockscreen" "waybar" "popups"];
      };
      animation = {
        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "easeinoutsine, 0.37, 0, 0.63, 1"
        ];
        animation = [
          "windowsIn, 1, 1.7, easeOutCubic, slide" # window open
          "windowsOut, 1, 1.7, easeOutCubic, slide" # window close
          "windowsMove, 1, 2.5, easeinoutsine, slide" # everything in between, moving, dragging, resizing

          # fading
          "fadeIn, 1, 3, easeOutCubic" # fade in (open) -> layers and windows
          "fadeOut, 1, 3, easeOutCubic" # fade out (close) -> layers and windows
          "fadeSwitch, 1, 5, easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow, 1, 5, easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim, 1, 6, fluent_decel" # the easing of the dimming of inactive windows
          "border, 1, 2.7, easeOutCirc" # for animating the border's color switch speed
          "workspaces, 1, 2, fluent_decel, slide" # styles: slide, slidevert, fade, slidefade, slidefadevert
          "specialWorkspace, 1, 3, fluent_decel, slidevert"
        ];
      };
      dwindle = {
        no_gaps_when_only = false;
        pseudotile = true;
        preserve_split = true;
      };
      master = {new_status = "master";};
      debug.disable_logs = false;

      "$VIDEODIR" = "$HOME/Videos";
      "$NOTIFY" = "notify-send -h string:x-canonical-private-synchronouse:hypr-cfg -u low";
      "$LAYERS" = "^(eww-.+|bar|system-menu|anyrun|gtk-layer-shell|osd[0-9]|dunst)$";

      bind = [
        "$MOD, Escape, exec, wlogout -p layer-shell"
        # "$MOD, Tab, exec, ags -t overview"

        # SSS
        "ALT, Print, exec, screenshot-full"
        "ALTSHIFT, S, exec, screenshot-area"
        # Normal Screenshot
        #", Print, exec, ags -r 'recorder.screenshot(true)'"
        #"$MODSHIFT, S, exec, ags -r 'recorder.screenshot()'"

        #"$MODSHIFT, X, exec, $COLORPICKER"

        "$MOD, R, exec, ${toggle "${anyrun-with-all-plugins}/bin/anyrun" true}"
        "$MOD, Return, exec, run-as-service ${pkgs.wezterm}/bin/wezterm"
        "CTRL_ALT, L, exec, loginctl lock-session"

        "$MOD, Q, killactive"
        "$MODSHIFT, Q, exit"
        "$MOD, F, fullscreen"
        "$MOD, Space, togglefloating"
        "$MOD, P, pseudo"
        "$MOD, S, togglesplit"

        "$MODSHIFT, Space, workspaceopt, allfloat"
        "$MODSHIFT, P, workspaceopt, allpseudotile"

        "ALT, Tab, cyclenext"
        "ALT, Tab, bringactivetotop"

        "$MOD, C, exec, hyprctl dispatch centerwindow"

        "$MOD, K, movefocus, u"
        "$MOD, J, movefocus, d"
        "$MOD, L, movefocus, r"
        "$MOD, H, movefocus, l"

        "$MODSHIFT, K, movewindow, u"
        "$MODSHIFT, J, movewindow, d"
        "$MODSHIFT, L, movewindow, r"
        "$MODSHIFT, H, movewindow, l"

        "$MODCTRL, K, resizeactive,  0 -20"
        "$MODCTRL, J, resizeactive,  0 20"
        "$MODCTRL, L, resizeactive,  20 0"
        "$MODCTRL, H, resizeactive, -20 0"

        "${builtins.concatStringsSep "\n" (builtins.genList (x: let
            ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in ''
            bind = $MOD, ${ws}, workspace, ${toString (x + 1)}
            bind = $MODSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
            bind = $MOD+CTRL, ${ws}, focusworkspaceoncurrentmonitor, ${toString (x + 1)}
          '')
          10)}"
        "$MOD, mouse_down, workspace, e-1"
        "$MOD, mouse_up, workspace, e+1"
      ];

      bindl = let
        e = "exec, wpctl";
      in [
        ", XF86AudioMute, ${e} set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, ${e} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioStop, exec, playerctl pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"
      ];

      bindle = let
        e = "exec, wpctl";
      in [
        ", XF86AudioRaiseVolume, ${e} set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, ${e} set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 5%-"
        # backlight
        ", XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5"
        ", XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5"
      ];

      bindm = ["$MOD, mouse:272, movewindow" "$MOD, mouse:273, resizewindow"];
      windowrulev2 = [
        # "opacity 0.90 0.90,class:^(org.wezfurlong.wezterm)$"
        # "opacity 0.90 0.90,class:^(Brave-browser)$"
        # "opacity 0.90 0.90,class:^(brave-browser)$"
        # "opacity 0.90 0.90,class:^(firefox)$"
        # "opacity 0.80 0.80,class:^(Steam)$"
        # "opacity 0.80 0.80,class:^(steam)$"
        # "opacity 0.80 0.80,class:^(steamwebhelper)$"
        # "opacity 0.80 0.80,class:^(Spotify)$"
        # "opacity 0.80 0.80,class:^(Code)$"
        # "opacity 0.80 0.80,class:^(thunar)$"
        # "opacity 0.80 0.80,class:^(file-roller)$"
        # "opacity 0.80 0.80,class:^(nwg-look)$"
        # "opacity 0.80 0.80,class:^(qt5ct)$"
        # "opacity 0.80 0.80,class:^(VencordDesktop|Webcord|discord|Discord)"
        # "opacity 0.80 0.70,class:^(pavucontrol)$"
        # "opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$"
        # "opacity 0.80 0.80,class:^(org.telegram.desktop)$"
        # "opacity 0.80 0.80,class:^(code-url-handler)$"
        # "opacity 0.80 0.80,title:^(Spotify( Premium)?)$"
        # "opacity 0.80 0.80,title:^(Spotify( Free)?)$"
        # "opacity 0.90 0.90, class:^(inlyne)$"
        # "opacity 0.90 0.90, class:^(org.qutebrowser.qutebrowser)$"

        "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "float,class:^(pavucontrol)$"
        "float,title:^(Media viewer)$"
        "float,title:^(Volume Control)$"
        "float,class:^(Viewnior)$"
        "float,title:^(DevTools)$"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"
        "float,class:^(mpv)$"
        "float,class:^(org.telegram.desktop)"
        "size 380 690,class:^(org.telegram.desktop)"
        "float,class:^(app.drey.PaperPlane)"
        "size 450 760,class:^(app.drey.PaperPlane)"

        "float, title:^(Picture-in-Picture)$"
        "pin, title:^(Picture-in-Picture)$"

        "idleinhibit focus, class:^(mpv|.+exe)$"
        "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
        "idleinhibit fullscreen, class:^(firefox)$"
        "idleinhibit fullscreen, class:^(Brave-browser)$"

        "dimaround, class:^(xdg-desktop-portal-gtk)$"
        "dimaround, class:^(polkit-gnome-authentication-agent-1)$"

        "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"
        "workspace special silent, title:^(Firefox — Sharing Indicator)$"

        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "nofocus,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"
        "noshadow,class:^(xwaylandvideobridge)$"
        "rounding 0, xwayland:1"
      ];
      layerrule = let
        toRegex = list: let
          elements = lib.concatStringsSep "|" list;
        in "^(${elements})$";

        lowopacity = [
          "bar"
          "notifications"
          "osd"
          "logout_dialog"
        ];

        highopacity = [
          # ags
          "calendar"
          "system-menu"

          "anyrun"
          "logout_dialog"
        ];

        blurred = lib.concatLists [
          lowopacity
          highopacity
        ];
      in [
        "blur, ${toRegex blurred}"
        "xray 1, ${toRegex ["bar"]}"
        "ignorealpha 0.5, ${toRegex (highopacity ++ ["music"])}"
        "ignorealpha 0.2, ${toRegex lowopacity}"
      ];
      plugin = {
        overview = {
          centerAligned = true;
          hideTopLayers = true;
          hideOverlayLayers = true;
          showNewWorkspace = true;
          exitOnClick = true;
          exitOnSwitch = true;
          drawActiveWorkspace = true;
          reverseSwipe = true;
        };
      };
    };
  };
}
