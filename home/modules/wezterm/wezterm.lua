-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.enable_wayland = true
-- config.color_scheme = "Catppuccin Macchiato"
-- config.color_scheme = "Tokyo Night"
-- config.color_scheme = "Dracula+"
config.color_scheme = 'Gruvbox Material (Gogh)'

config.font_size = 16.0

config.font = wezterm.font_with_fallback({
  { family = "Iosevka Nerd Font", weight="Light", stretch="Normal"},
  "JetBrainsMono Nerd Font Mono",
	"Noto Color Emoji",
  { family = "Font Awesome 6 Free", weight="Regular", stretch="Normal", style="Normal"}
})

config.keys = {

    { key = 't', mods = 'ALT', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'w', mods = 'ALT', action = act.CloseCurrentTab{ confirm = true } },
}

config.scrollback_lines = 200000
config.tab_max_width = 24
config.use_dead_keys = false
config.window_decorations = "RESIZE" -- no title bar
-- config.window_background_opacity = 0.95
-- and finally, return the configuration to wezterm
return config
