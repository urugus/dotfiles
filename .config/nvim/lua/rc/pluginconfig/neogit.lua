local neogit = require("neogit")
neogit.setup({
  kind = "tab",
  commit_popup = {
    kind = "split",
  },
  disable_commit_confirmation = true,
  disable_insert_on_commit = true,
  integrations = { diffview = true },
  sections = {
    stashes = {
      folded = false,
    },
    recent = { folded = false },
  },
})

vim.api.nvim_set_keymap("n", "[git]<Space>", "<Cmd>Neogit<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[git]s", "<Cmd>Neogit<CR>", { noremap = true, silent = true })
