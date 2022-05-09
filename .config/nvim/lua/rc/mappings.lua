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

-- custom leader
g.mapleader = "<Space>"

-- tab move
-- map("n", "C-,", ":+tabmove<CR>", { noremap = true, silent = true })
-- map("n", "C-.", ":-tabmove<CR>", { noremap = true, silent = true })


-- comand mode
map("c", "<C-k>", "<Up>", { noremap = true, silent = true })
map("c", "<C-j>", "<Down>", { noremap = true, silent = true })
map("c", "<C-l>", "<Left>", { noremap = true, silent = true })
map("c", "<C-h>", "<Right>", { noremap = true, silent = true })


-- terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = false })

