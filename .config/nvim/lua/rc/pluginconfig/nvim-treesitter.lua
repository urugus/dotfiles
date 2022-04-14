-- vim.keymap.set("n", "[ts]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "'", "[ts]", {})

require'nvim-treesitter.configs'.setup {
}
