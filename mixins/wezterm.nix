{
  pkgs,
  config,
  inputs,
  ...
}:

let
  prefs = import ./_preferences.nix { inherit pkgs inputs; };
  colors = prefs.themes.wezterm;

  enable_wayland = "true";

  weztermPkg = pkgs.wezterm;
  # weztermPkg = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.wezterm;
in
{
  config = {
    # nixpkgs.overlays = [
    #   (final: prev: { wezterm = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.wezterm; })
    # ];
    home-manager.users.bruce =
      { pkgs, ... }@hm:
      {
        home.packages = [ weztermPkg ];

        xdg.configFile."wezterm/wezterm.lua".text = ''
          local wezterm = require 'wezterm';

          wezterm.add_to_config_reload_watch_list("${hm.config.xdg.configHome}/wezterm")

          local config = {
            default_prog = { "${prefs.default_shell}" },
            enable_tab_bar = false,
            use_fancy_tab_bar = false,
            front_end = "WebGpu",
            initial_rows = 24,
            initial_cols = 120,
            font_size = ${toString prefs.font.size},
            window_background_opacity = 1.0,
            enable_csi_u_key_encoding = true,
            default_cursor_style = 'BlinkingBar',
            colors = {
              foreground = "${colors.foreground}",
              background = "${colors.background}",
              ansi = {
                "${colors.black}",
                "${colors.red}",
                "${colors.green}",
                "${colors.yellow}",
                "${colors.blue}",
                "${colors.purple}",
                "${colors.cyan}",
                "${colors.white}"
              },
              brights = {
                "${colors.brightBlack}",
                "${colors.brightRed}",
                "${colors.brightGreen}",
                "${colors.brightYellow}",
                "${colors.brightBlue}",
                "${colors.brightPurple}",
                "${colors.brightCyan}",
                "${colors.brightWhite}"
              },
            }
          }

          if wezterm.target_triple == "x86_64-pc-windows-msvc" then
            config.default_prog = { "powershell.exe" }
          else
            config.enable_wayland = ${enable_wayland}
            -- config.window_decorations = "TITLE"
            config.window_close_confirmation = "NeverPrompt"
            -- config.freetype_load_target = "Light"
            -- config.freetype_render_target = "HorizontalLcd"
            local f = wezterm.font_with_fallback({
              {family="${prefs.font.monospace.family}", weight="Regular"},
              {family="Font Awesome", weight="Regular"},
            })
            config.font = f;
          end

          wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
            local zoomed = ""
            if tab.active_pane.is_zoomed then
              zoomed = "[Z] "
            end

            local index = ""
            if #tabs > 1 then
              index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
            end

            local title = string.format("%s - wezterm", tab.active_pane.title)

            return zoomed .. index .. title
          end)

          -- issue#3142 workaround START
          local wezterm_action = wezterm.action
          local act = wezterm.action
          config.mouse_bindings = {
            {
              event = { Down = { streak = 1, button = { WheelUp = 1 } } },
              mods = 'NONE',
              action = wezterm_action.ScrollByLine(-1),
            },
            {
              event = { Down = { streak = 1, button = { WheelDown = 1 } } },
              mods = 'NONE',
              action = wezterm_action.ScrollByLine(1),
            },
          }
          -- issue#3142 workaround END

          return config
        '';
      };
  };
}
