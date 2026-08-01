-- v3 のデフォルトで運用する。診断アイコンは rc/lsp/diagnostic.lua の vim.diagnostic.config 由来。
require("trouble").setup({})

local opts = { silent = true, noremap = true }
vim.keymap.set("n", "[_Lsp]xx", "<Cmd>Trouble diagnostics toggle<CR>", opts)
vim.keymap.set("n", "[_Lsp]xd", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", opts)
vim.keymap.set("n", "[_Lsp]xl", "<Cmd>Trouble loclist toggle<CR>", opts)
vim.keymap.set("n", "[_Lsp]xq", "<Cmd>Trouble qflist toggle<CR>", opts)
