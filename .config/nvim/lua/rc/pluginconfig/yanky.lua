local clipboard = vim.o.clipboard
vim.o.clipboard = ""

require("yanky").setup({
  ring = {
    sync_with_numbered_registers = false,
  },
  system_clipboard = {
    sync_with_ring = false,
  },
})

vim.o.clipboard = clipboard

-- キーマップ (p / P / gp / gP / y) は rc/keymaps/plugins.lua にある
