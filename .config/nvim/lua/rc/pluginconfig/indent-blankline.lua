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
      "dashpreview",
      "NvimTree",
      "neo-tree",
      "vista",
      "sagahover",
      "sagasignature",
      "packer",
      "log",
      "lspsagafinder",
      "lspinfo",
      "dapui_scopes",
      "dapui_breakpoints",
      "dapui_stacks",
      "dapui_watches",
      "dap-repl",
      "toggleterm",
      "alpha",
      "coc-explorer",
    },
  },
  scope = { enabled = false },
})
