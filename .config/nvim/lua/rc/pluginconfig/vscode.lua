vim.o.background = "dark"

local vscode = require("vscode")

vscode.setup({
  style = "dark",
  -- Enable transparent background
  transparent = true,

  -- Enable italic comment
  italic_comments = true,

  -- Disable nvim-tree background color
  disable_nvimtree_bg = true,

  -- Override colors (see ./lua/vscode/colors.lua)
  color_overrides = {
    vscLineNumber = "#FFFFFF",
  },
})

vim.cmd.colorscheme("vscode")
