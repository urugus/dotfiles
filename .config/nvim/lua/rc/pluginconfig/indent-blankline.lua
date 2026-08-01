local highlight = {
  "CursorColumn",
  "Whitespace",
}

require("ibl").setup({
  indent = {
    highlight = highlight,
    char = "",
  },
  whitespace = {
    highlight = highlight,
    remove_blankline_trail = false,
  },
  exclude = {
    filetypes = {
      "help",
      "dashboard",
      "log",
      "lspinfo",
      "neo-tree",
      "toggleterm",
    },
  },
  scope = { enabled = false },
})
