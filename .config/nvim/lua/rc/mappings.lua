---------------------------------------------------------------------------------------------------+
-- Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator | Terminal | Lang-Arg |
-- ================================================================================================+
-- map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |    -     |    -     |
-- nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |    -     |    -     |
-- map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    -     |
-- imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |    -     |    -     |
-- cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |    -     |    -     |
-- vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |    -     |    -     |
-- xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |    -     |    -     |
-- smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |    -     |    -     |
-- omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |    -     |    -     |
-- tmap / tnoremap  |    -   |   -    |    -    |   -    |   -    |    -     |    @     |    -     |
-- lmap / lnoremap  |    -   |   @    |    @    |   -    |   -    |    -     |    -     |    @     |
---------------------------------------------------------------------------------------------------+

-- variants
local g = vim.g
local map = vim.keymap.set
local o = vim.o
local api = vim.api

-- input
map('i', '<C-j>', '<Plug>(skkeleton-toggle)', { silent = true })
map('c', '<C-j>', '<Plug>(skkeleton-toggle)', { silent = true })

-- buffer move
map("n", "<Leader>b", "<Cmd>BufferLinePick<CR>", { noremap = true, silent = true })
map("n", "<C-h>", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true })
map("n", "<C-l>", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true })
map("n", "<<", "<Cmd>BufferLineMovePrev<CR>", { noremap = true, silent = true })
map("n", ">>", "<Cmd>BufferLineMoveNext<CR>", { noremap = true, silent = true })
map("n", "<C-S-F2>", "<Cmd>BufferLineMovePrev<CR>", { noremap = true, silent = true })
map("n", "<C-S-F3>", "<Cmd>BufferLineMoveNext<CR>", { noremap = true, silent = true })

map("n", "<Space>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
map("n", "<Space>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
map("n", "<Space>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
map("n", "<Space>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
map("n", "<Space>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
map("n", "<Space>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
map("n", "<Space>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
map("n", "<Space>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
map("n", "<Space>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })

-- tab move
map("n", "<C-t>n", ":tab new<CR>", { noremap = true, silent = true })

-- terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = false })

-- sandwich & <spector>
map({ "n", "x" }, "s", "<Nop>", { noremap = true, silent = true })
map({ "n", "x" }, "S", "<Nop>", { noremap = true, silent = true })

-- [_Lsp] vim.keymap.set("n", ";", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "[_Lsp]", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", ";", "[_Lsp]", {})

-- [Copilot]
api.nvim_set_keymap("n", "[Copilot]", "<Nop>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>c", "[Copilot]", {})

--[git]
api.nvim_set_keymap("n", "<Leader>g", "[git]", {})

-- [FuzzyFinder]
map({ "n", "x" }, "z", "<Nop>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "[FuzzyFinder]", "<Nop>", { noremap = true, silent = true })
api.nvim_set_keymap("v", "[FuzzyFinder]", "<Nop>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "z", "[FuzzyFinder]", {})
api.nvim_set_keymap("v", "z", "[FuzzyFinder]", {})
api.nvim_set_keymap("n", "Z", "<Nop>", { noremap = true, silent = true })

-- treesitter
vim.keymap.set("n", "'", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'zf', 'zfa{', { noremap = true, silent = true })

---- remap
map("n", "gzz", "zz", { noremap = true, silent = true })
map("n", "gj", "j", { noremap = true, silent = true })
map("n", "gk", "k", { noremap = true, silent = true })
map("n", "X", "<Cmd>tabclose<CR>", { noremap = true, silent = true })

-- move cursor
vim.keymap.set({ "n", "x" }, "j", function()
  return vim.v.count > 0 and "j" or "gj"
end, { noremap = true, expr = true })
vim.keymap.set({ "n", "x" }, "k", function()
  return vim.v.count > 0 and "k" or "gk"
end, { noremap = true, expr = true })

-- ハイライトを消す
map("n", "gq", "<Cmd>nohlsearch<CR>", { noremap = true, silent = true })

-- インクリメント設定
map({ "n", "x" }, "+", "<C-a>", { noremap = true, silent = true })
map({ "n", "x" }, "_", "<C-x>", { noremap = true, silent = true })

-- paste
map({ "n", "x" }, "p", "]p", { noremap = true, silent = true })
map({ "n", "x" }, "gp", "p", { noremap = true, silent = true })
map({ "n", "x" }, "gP", "P", { noremap = true, silent = true })
map({ "n", "x" }, "<LocalLeader>p", '"+p', { noremap = true, silent = true })
map({ "n", "x" }, "<LocalLeader>P", '"+P', { noremap = true, silent = true })
