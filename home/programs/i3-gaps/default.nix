{ pkgs, lib, ... }:

let
  modifier = "Mod4";
  workspace = {
    terminal = "terminal";
    neovim = "nvim";
    browser = "firefox";
    ledger = "ledger";
    extra = "extra";
  };
in {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        inherit modifier;

        bars = [ ];

        window = {
          border = 0;
          hideEdgeBorders = "both";

          commands = [
            # Start chromium in fullscreen by default.
            {
              command = "fullscreen enable";
              criteria = { class = "Chromium-browser"; };
            }

            # Start vsneovim in fullscreen by default.
            {
              command = "fullscreen enable";
              criteria = { class = "neovim"; };
            }

          ];
        };

        gaps = {
          inner = 10;
          outer = 5;
        };

        keybindings = {
          # Alacritty terminal
          "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";

          # Rofi
          "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";

          # Screenshot
          "${modifier}+shift+s" = "exec ${pkgs.flameshot}/bin/flameshot gui -c";
          "${modifier}+shift+a" = "exec ${pkgs.flameshot}/bin/flameshot gui";

          # Movement
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+h" = "focus left";
          "${modifier}+l" = "focus right";

          # Workspaces
          "${modifier}+space" = "workspace ${workspace.terminal}";
          "${modifier}+m" = "workspace ${workspace.neovim}";
          "${modifier}+comma" = "workspace ${workspace.browser}";
          "${modifier}+o" = "workspace ${workspace.ledger}";
          "${modifier}+p" = "workspace ${workspace.extra}";

          # Misc
          "${modifier}+shift+q" = "kill";
          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+z" = "split h";
          "${modifier}+x" = "split v";
          "${modifier}+r" = "mode resize";
        };

        assigns = {
          ${workspace.neovim} = [{ class = "Code"; }];
          ${workspace.browser} = [{ class = "Chromium-browser"; }];
          ${workspace.ledger} = [ {class = "Ledger Live";} ];
        };

        modes.resize = {
          "h" = "resize grow width 10 px or 10 ppt";
          "j" = "resize shrink height 10 px or 10 ppt";
          "k" = "resize grow height 10 px or 10 ppt";
          "l" = "resize shrink width 10 px or 10 ppt";
          "Escape" = "mode default";
        };

        startup = [
          {
            command = "${pkgs.xmousepasteblock}/bin/xmousepasteblock";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.feh}/bin/feh --bg-fill ~/.background.webp";
            always = true;
            notification = false;
          }
          {
            command = "systemctl --user restart polybar.service";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.xbanish}/bin/xbanish";
            always = true;
            notification = false;
          }
          {
            command = "${pkgs.chromium}/bin/chromium --restore-last-session";
            always = false;
            notification = false;
          }
          {
            command = "${pkgs.i3}/bin/i3-msg workspace ${workspace.terminal}";
            always = false;
            notification = false;
          }
          {
            command = "${pkgs.alacritty}/bin/alacritty";
            always = false;
            notification = false;
          }
        ];
      };
    };
  };
  home.file.".background.webp".source = ./background.webp;
}
