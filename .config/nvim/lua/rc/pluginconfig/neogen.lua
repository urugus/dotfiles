require("neogen").setup({
  enabled = true,
  languages = {
    ruby = {
      annotation_convention = "yard",
    },
  },
})

vim.keymap.set("n", "gca", "<Cmd>lua require('neogen').generate()<CR>", { noremap = true, silent = true })
