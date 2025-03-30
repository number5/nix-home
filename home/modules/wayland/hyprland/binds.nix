let
  toggle = program: let
    prog = builtins.substring 0 14 program;
  in "pkill ${prog} || uwsm app -- ${program}";

  runOnce = program: "pgrep ${program} || uwsm app -- ${program}";
in {
  wayland.windowManager.hyprland.settings = {
  
    monitor = [
      "eDP-1, prefered, auto"
      "DP-1, prefered, auto"
      ];
    workspace = [
   "eDP-1, 1"
   "DP-1, 11"

  "1,monitor:eDP-1"
  "2,monitor:eDP-1"
  "3,monitor:eDP-1"
  "4,monitor:eDP-1"
  "5,monitor:eDP-1"

  "11,monitor:DP-1"
  "12,monitor:DP-1"
  "13,monitor:DP-1"
  "14,monitor:DP-1"
  "15,monitor:DP-1"

    ];
    # mouse movements
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];

    # binds
    bind =
      [
        # compositor commands
        "$mod SHIFT, E, exec, pkill Hyprland"
        "$mod, Q, killactive,"
        "$mod, F, fullscreen,"
        "$mod, G, togglegroup,"
        "$mod SHIFT, N, changegroupactive, f"
        "$mod SHIFT, P, changegroupactive, b"
        "$mod, R, togglesplit,"
        "$mod, T, togglefloating,"
        "$mod ALT, ,resizeactive,"


        # utility
        # terminal
        "$mod, Return, exec, uwsm app -- foot"
        # logout menu
        "$mod, Escape, exec, ${toggle "wlogout"} -p layer-shell"
        # lock screen
        "$mod, L, exec, ${runOnce "hyprlock"}"
        # lock screen, to be used with the special key Fn+F10 on my keyboard
        "$mod, I, exec, ${runOnce "hyprlock"}"
        # select area to perform OCR on
        "$mod, O, exec, ${runOnce "wl-ocr"}"
        ", XF86Favorites, exec, ${runOnce "wl-ocr"}"

        "$mod, P, exec, wofi --show run --style=${./wofi.css} --term=footclient --prompt=Run"

        # move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # screenshot
        # area
        ", Print, exec, ${runOnce "grimblast"} --notify copysave area"
        "$mod SHIFT, R, exec, ${runOnce "grimblast"} --notify copysave area"

        # current screen
        "CTRL, Print, exec, ${runOnce "grimblast"} --notify --cursor copysave output"
        "$mod SHIFT CTRL, R, exec, ${runOnce "grimblast"} --notify --cursor copysave output"

        # all screens
        "ALT, Print, exec, ${runOnce "grimblast"} --notify --cursor copysave screen"
        "$mod SHIFT ALT, R, exec, ${runOnce "grimblast"} --notify --cursor copysave screen"

        # special workspace
        "$mod SHIFT, grave, movetoworkspace, special"
        "$mod, grave, togglespecialworkspace, eDP-1"

        # cycle workspaces
        "$mod, bracketleft, workspace, m-1"
        "$mod, bracketright, workspace, m+1"

        # cycle monitors
        "$mod SHIFT, bracketleft, focusmonitor, l"
        "$mod SHIFT, bracketright, focusmonitor, r"

        # send focused workspace to left/right monitors
        "$mod SHIFT ALT, bracketleft, movecurrentworkspacetomonitor, l"
        "$mod SHIFT ALT, bracketright, movecurrentworkspacetomonitor, r"

        # workspaces
        "$mod ,1,exec,hyprsome workspace 1"
        "$mod ,2,exec,hyprsome workspace 2"
        "$mod ,3,exec,hyprsome workspace 3"
        "$mod ,4,exec,hyprsome workspace 4"
        "$mod ,5,exec,hyprsome workspace 5"

        "$mod SHIFT,1,exec,hyprsome move 1"
        "$mod SHIFT,2,exec,hyprsome move 2"
        "$mod SHIFT,3,exec,hyprsome move 3"
        "$mod SHIFT,4,exec,hyprsome move 4"
        "$mod SHIFT,5,exec,hyprsome move 5"
    ];

    bindl = [
      # media controls
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"

      # volume
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];

    bindle = [
      # volume
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"

      # backlight
      ", XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5"
      ", XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5"
    ];
  };
}
