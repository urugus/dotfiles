vim.g.indent_blankline_enabled = true
vim.opt.termguicolors = true

require("indent_blankline").setup({
  use_treesitter = true,
  buftype_exclude = { "terminal" },
  filetype_exclude = {
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
  show_current_context = true,
  show_current_context_start = true,
})

