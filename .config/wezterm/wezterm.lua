local wezterm = require "wezterm"
local act = wezterm.action

---------------------------------------------------------------
--- Config
---------------------------------------------------------------

return  {
  use_ime = true,
  window_background_opacity = 0.8,
  keys = {
    -- default keybinds
    { key = "-", mods = "ALT", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
    { key = "\\", mods = "ALT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
    { key = "c", mods = "ALT", action = act({ CopyTo = "Clipboard" }) },
    { key = "v", mods = "ALT", action = act({ PasteFrom = "Clipboard" }) },
  },
  font = wezterm.font 'JetBrains Mono',
}
