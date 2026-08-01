-- select / swap / move のキーマップは rc/keymaps/plugins.lua にある
require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
  },
  move = {
    set_jumps = true,
  },
})
