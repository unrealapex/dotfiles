-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'

config.font = wezterm.font_with_fallback({
  -- <built-in>, BuiltIn
  "Jetbrains Mono Nerd Font Mono",
  "Segoe UI Emoji",
})

config.keys = {
  {
    key = "Backspace",
    mods = "CTRL",
    action = wezterm.action.SendKey({ key = "Backspace", mods = "ALT" }),
  },
}
config.window_background_opacity = 0.65
config.enable_tab_bar = false
-- and finally, return the configuration to wezterm
return config
