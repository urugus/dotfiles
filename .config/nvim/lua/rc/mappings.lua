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
local map = vim.keymap.set
local api = vim.api

-- AquaSKK: InsertLeave時にASCIIモードに切り替え
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    -- 複数の方法を組み合わせて確実に切り替える
    vim.defer_fn(function()
      -- 1. まずim-selectでABCに切り替え
      vim.fn.system("/opt/homebrew/bin/im-select jp.sourceforge.inputmethod.aquaskk")
      -- 2. 少し待ってからAquaSKKのASCIIモードに戻す
      vim.defer_fn(function()
        vim.fn.system("/opt/homebrew/bin/im-select jp.sourceforge.inputmethod.aquaskk.Ascii")
      end, 100)
    end, 10)
  end,
  desc = "Switch to ASCII mode when leaving insert mode",
})

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

-- [_Lsp]
api.nvim_set_keymap("n", "[_Lsp]", "<Nop>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>l", "[_Lsp]", {})

-- [Copilot]
api.nvim_set_keymap("n", "[Copilot]", "<Nop>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>c", "[Copilot]", {})

--[git]
map("n", "<C-g>", function()
  require("snacks").lazygit()
end, { noremap = true, silent = true, desc = "Open LazyGit" })
api.nvim_set_keymap("n", "<Leader>g", "[git]", {})
map("n", "[git]o", function()
  require("snacks").gitbrowse({ notify = true })
end, { noremap = true, silent = true })
api.nvim_set_keymap("n", "[Octo]", "<Nop>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>gg", "[Octo]", {})
api.nvim_set_keymap("v", "<Leader>gg", "[Octo]", {})
api.nvim_set_keymap("n", "[Octo]l", "<Cmd>Octo pr list<Cr>", {})
api.nvim_set_keymap("n", "[Octo]is", "<Cmd>Octo issue search<Cr>", {})
api.nvim_set_keymap("n", "[Octo]ib", "<Cmd>Octo issue browser<Cr>", {})
api.nvim_set_keymap("n", "[Octo]ps", "<Cmd>Octo pr search<Cr>", {})
api.nvim_set_keymap("n", "[Octo]pn", "<Cmd>Octo pr create<Cr>", {})
api.nvim_set_keymap("n", "[Octo]pp", "<Cmd>Octo pr draft<Cr>", {})
api.nvim_set_keymap("n", "[Octo]pb", "<Cmd>Octo pr browser<Cr>", {})
api.nvim_set_keymap("n", "[Octo]rva", "<Cmd>Octo reviewer add<Cr>", {})
api.nvim_set_keymap("n", "[Octo]rs", "<Cmd>Octo review start<Cr>", {})
api.nvim_set_keymap("n", "[Octo]re", "<Cmd>Octo review submit<Cr>", {})
api.nvim_set_keymap("n", "[Octo]rc", "<Cmd>Octo review comments<Cr>", {})

-- [LSP]
map("n", "gd", function()
  require("snacks").picker.lsp_definitions()
end, { noremap = true, silent = true })
map("n", "gD", function()
  require("snacks").picker.lsp_declarations()
end, { noremap = true, silent = true })
map("n", "gr", function()
  require("snacks").picker.lsp_references()
end, { noremap = true, silent = true })
map("n", "gI", function()
  require("snacks").picker.lsp_implementations()
end, { noremap = true, silent = true })
map("n", "gy", function()
  require("snacks").picker.lsp_type_definitions()
end, { noremap = true, silent = true })

-- [FuzzyFinder]
api.nvim_set_keymap("n", "[FuzzyFinder]", "<Nop>", { noremap = true, silent = true })
api.nvim_set_keymap("v", "[FuzzyFinder]", "<Nop>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Leader>f", "[FuzzyFinder]", {})
api.nvim_set_keymap("v", "<Leader>f", "[FuzzyFinder]", {})
map("n", "<Leader><Leader>", function()
  require("snacks").picker.smart({ ignored = true, hidden = true })
end, { noremap = true, silent = true })
map("n", "[FuzzyFinder].", function()
  require("snacks").picker.files({ ignored = true, hidden = true })
end, { noremap = true, silent = true })
map("n", "[FuzzyFinder],", function()
  require("snacks").picker.buffers({
    unloaded = true,
    current = true,
    sort_lastused = true,
    win = {
      list = { keys = { ["dd"] = "bufdelete" } },
    },
  })
end, { noremap = true, silent = true })
map("n", "[FuzzyFinder]h", function()
  require("snacks").picker.search_history()
end, { noremap = true, silent = true })
map("n", "[FuzzyFinder]r", function()
  require("snacks").picker.registers()
end, { noremap = true, silent = true })
map("n", "[FuzzyFinder]k", function()
  require("snacks").picker.keymaps()
end, { noremap = true, silent = true })
map("n", "[FuzzyFinder]/", function()
  require("snacks").picker.grep({ cmd = "rg", regex = true, live = true })
end, { noremap = true, silent = true })
map("n", "[FuzzyFinder]sw", function()
  require("snacks").picker.grep_word({ cmd = "rg", live = true })
end, { noremap = true, silent = true })
map("n", "[FuzzyFinder]ss", function()
  require("snacks").picker.lsp_symbols({ live = true })
end, { noremap = true, silent = true })
map("n", "[FuzzyFinder]gl", function()
  require("snacks").picker.git_log({ live = true })
end, { noremap = true, silent = true })
map("n", "[FuzzyFinder]n", function()
  require("snacks").picker.notifications()
end, { noremap = true, silent = true })
map("n", "[FuzzyFinder]m", function()
  require("snacks").picker.marks()
end, { noremap = true, silent = true })
map("n", "[FuzzyFinder]p", function()
  require("snacks").picker.projects()
end, { noremap = true, silent = true })
map("n", "[FuzzyFinder]sp", function()
  require("snacks").picker.spelling()
end, { noremap = true, silent = true })

---- remap
map("n", "gzz", "zz", { noremap = true, silent = true })
map("n", "gj", "j", { noremap = true, silent = true })
map("n", "gk", "k", { noremap = true, silent = true })
map("n", "Q", "<Cmd>tabclose<CR>", { noremap = true, silent = true })

-- move cursor
map({ "n", "x" }, "j", function()
  return vim.v.count > 0 and "j" or "gj"
end, { noremap = true, expr = true })
map({ "n", "x" }, "k", function()
  return vim.v.count > 0 and "k" or "gk"
end, { noremap = true, expr = true })

-- ハイライトを消す
map("n", "gq", "<Cmd>nohlsearch<CR>", { noremap = true, silent = true })

-- インクリメント設定
map({ "n", "x" }, "+", "<C-a>", { noremap = true, silent = true })
map({ "n", "x" }, "-", "<C-x>", { noremap = true, silent = true })

-- paste
map({ "n", "x" }, "p", "]p", { noremap = true, silent = true })
map({ "n", "x" }, "gp", "p", { noremap = true, silent = true })
map({ "n", "x" }, "gP", "P", { noremap = true, silent = true })
map({ "n", "x" }, "<LocalLeader>p", '"+p', { noremap = true, silent = true })
map({ "n", "x" }, "<LocalLeader>P", '"+P', { noremap = true, silent = true })

-- [Markdown]
map("n", "<Leader>mo", "<Cmd>MarkdownOpen<CR>", { noremap = true, silent = true })
map("n", "<Leader>mc", "<Cmd>MarkdownClose<CR>", { noremap = true, silent = true })

-- [Window]
map("n", "<Leader>wc", "<Cmd>NoNeckPain<CR>", { noremap = true, silent = true })
