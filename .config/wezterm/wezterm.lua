local wezterm = require("wezterm")
local act = wezterm.action
require("on")

---------------------------------------------------------------
--- Config
---------------------------------------------------------------

return {
  animation_fps = 10,
  use_ime = true,
  macos_forward_to_ime_modifier_mask = "CTRL|SHIFT",
  window_background_opacity = 0.7,
  macos_window_background_blur = 2,
  freetype_load_target = "Light",
  front_end = "WebGpu",
  cell_width = 0.9,
  keys = {
    -- default keybinds
    { key = "-", mods = "ALT", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
    { key = "\\", mods = "ALT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
    { key = "c", mods = "ALT", action = act({ CopyTo = "Clipboard" }) },
    { key = "v", mods = "ALT", action = act({ PasteFrom = "Clipboard" }) },
    { key = "x", mods = "ALT", action = act({ CloseCurrentPane = { confirm = true } }) },
  },
  font = wezterm.font_with_fallback({
    "UDEV Gothic LG",
    "Hack Nerd Font",
    "Fira Code",
  }),
}
