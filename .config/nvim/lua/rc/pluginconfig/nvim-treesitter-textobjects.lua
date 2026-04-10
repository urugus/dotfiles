local select = require("nvim-treesitter-textobjects.select")
local swap = require("nvim-treesitter-textobjects.swap")
local move = require("nvim-treesitter-textobjects.move")

require("nvim-treesitter-textobjects").setup({
  select = {
    lookahead = true,
  },
  move = {
    set_jumps = true,
  },
})

-- Select
local select_maps = {
  ["af"] = "@function.outer",
  ["if"] = "@function.inner",
  ["ac"] = "@class.outer",
  ["ic"] = "@class.inner",
  ["iB"] = "@block.inner",
  ["aB"] = "@block.outer",
  ["ii"] = "@conditional.inner",
  ["ai"] = "@conditional.outer",
  ["il"] = "@loop.inner",
  ["al"] = "@loop.outer",
  ["ip"] = "@parameter.inner",
  ["ap"] = "@parameter.outer",
}

for lhs, capture in pairs(select_maps) do
  vim.keymap.set({ "x", "o" }, lhs, function()
    select.select_textobject(capture, "textobjects")
  end, { desc = "TS " .. capture })
end

-- Swap
vim.keymap.set("n", "'>", function()
  swap.swap_next("@parameter.inner")
end, { desc = "TS swap next parameter" })

vim.keymap.set("n", "'<", function()
  swap.swap_previous("@parameter.inner")
end, { desc = "TS swap prev parameter" })

-- Move
local move_maps = {
  { "]m", move.goto_next_start, "@function.outer" },
  { "]M", move.goto_next_end, "@function.outer" },
  { "]]", move.goto_next_start, "@class.outer" },
  { "][", move.goto_next_end, "@class.outer" },
  { "[m", move.goto_previous_start, "@function.outer" },
  { "[M", move.goto_previous_end, "@function.outer" },
  { "[[", move.goto_previous_start, "@class.outer" },
  { "[]", move.goto_previous_end, "@class.outer" },
}

for _, m in ipairs(move_maps) do
  vim.keymap.set({ "n", "x", "o" }, m[1], function()
    m[2](m[3], "textobjects")
  end, { desc = "TS move " .. m[3] })
end
