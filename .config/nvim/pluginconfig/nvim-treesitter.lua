require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
  fold = {
    enable = true,
  },
  indent = {
    enable = true,
  }
})

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
