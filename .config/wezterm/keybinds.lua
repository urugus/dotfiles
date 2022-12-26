local M = {}
local wezterm = require("wezterm")
local act = wezterm.action
local utils  = require("utils")

---------------------------------------------------------------
--- keybinds
---------------------------------------------------------------

M.default_keybinds = {
  { key = "c", mods = "CTRL|SHIFT", action = act({ CopyTo = "Clipboard" }) },
  { key = "v", mods = "CTRL|SHIFT", action = act({ PasteFrom = "Clipboard" }) },
}

M.customization = {
  { key = "-", mods = "ALT", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
  { key = "\\", mods = "ALT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) }
}

function M.create_keybinds()
  return utils.merge_list(M.default_keybinds, M.customized_keybinds)
end

return M
