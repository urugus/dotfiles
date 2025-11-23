require("copilot").setup({
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = "<C-Tab>",
      accept_word = false,
      accept_line = false,
      next = "<C-S-n",
      prev = "<C-S-p>",
      dismiss = "<C-c>d",
    },
  },
})
