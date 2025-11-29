-- Main snacks.nvim configuration
-- Modular config split into snacks/ subdirectory
local snacks = require("snacks")

local ui = require("rc.pluginconfig.snacks.ui")
local dashboard = require("rc.pluginconfig.snacks.dashboard")
local picker = require("rc.pluginconfig.snacks.picker")

snacks.setup({
  -- UI settings
  animate = ui.animate,
  bigfile = ui.bigfile,
  gitbrowse = ui.gitbrowse,
  indent = ui.indent,
  lazygit = ui.lazygit,
  notifier = ui.notifier,
  scroll = ui.scroll,

  -- Dashboard
  dashboard = dashboard,

  -- Picker
  picker = picker,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.cmd("highlight SnacksIndent guifg=#888888 gui=nocombine")
    vim.cmd("highlight SnacksIndentScope guifg=#cd5c5c gui=nocombine")
  end,
})
