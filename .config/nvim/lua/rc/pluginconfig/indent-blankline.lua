vim.g.indent_blankline_enabled = false
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#1a1a1a gui=nocombine]]

require("indent_blankline").setup({
	show_current_context = false,
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
  char = "",
  char_highlight_list = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
  },
  space_char_highlight_list = {
      "IndentBlanklineIndent1",
      "IndentBlanklineIndent2",
  },
  show_trailing_blankline_indent = false,
})

vim.api.nvim_clear_autocmds({ event = { "TextChanged", "TextChangedI" }, group = "IndentBlanklineAutogroup" })
