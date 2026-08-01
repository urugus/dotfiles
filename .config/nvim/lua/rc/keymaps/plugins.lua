local set = require("rc.keymaps.util").set
local lsp_location = require("rc.lsp.locate").location

local function has_deno()
  return vim.fn.executable("deno") == 1
end

-- nvim-treesitter-textobjects の select / move は組み合わせが多いので表から生成する
local ts_select = {
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

local ts_move = {
  { "]m", "goto_next_start", "@function.outer" },
  { "]M", "goto_next_end", "@function.outer" },
  { "]]", "goto_next_start", "@class.outer" },
  { "][", "goto_next_end", "@class.outer" },
  { "[m", "goto_previous_start", "@function.outer" },
  { "[M", "goto_previous_end", "@function.outer" },
  { "[[", "goto_previous_start", "@class.outer" },
  { "[]", "goto_previous_end", "@class.outer" },
}

local function treesitter_textobject_maps()
  local maps = {}

  for lhs, capture in pairs(ts_select) do
    table.insert(maps, {
      { "x", "o" },
      lhs,
      function()
        require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
      end,
      { desc = "TS " .. capture },
    })
  end

  for _, m in ipairs(ts_move) do
    local lhs, fn, capture = m[1], m[2], m[3]
    table.insert(maps, {
      { "n", "x", "o" },
      lhs,
      function()
        require("nvim-treesitter-textobjects.move")[fn](capture, "textobjects")
      end,
      { desc = "TS move " .. capture },
    })
  end

  return maps
end

return function()
  set({
    ------------------------------------------------------------
    -- プレフィックス
    { "n", "[_Lsp]", "<Nop>" },
    { "n", "<Leader>l", "[_Lsp]", { remap = true, desc = "LSP prefix" } },

    { "n", "[git]", "<Nop>" },
    { "n", "<Leader>g", "[git]", { remap = true, desc = "Git prefix" } },

    { "n", "[Octo]", "<Nop>" },
    { "n", "<Leader>o", "[Octo]", { remap = true, desc = "Octo prefix" } },

    { "n", "[FuzzyFinder]", "<Nop>" },
    { "n", "<Leader>f", "[FuzzyFinder]", { remap = true, desc = "Finder prefix" } },

    { "n", "[ufo]", "<Nop>" },
    { "n", "<Leader>z", "[ufo]", { remap = true, desc = "Fold prefix" } },

    ------------------------------------------------------------
    -- which-key (プレフィックスの一覧表示)
    { "n", "<LocalLeader><CR>", "<Cmd>WhichKey <LocalLeader><CR>" },
    { "n", "[_Lsp]<CR>", "<Cmd>WhichKey [_Lsp]<CR>" },
    { "n", "[git]<CR>", "<Cmd>WhichKey [git]<CR>" },
    { "n", "[Octo]<CR>", "<Cmd>WhichKey [Octo]<CR>" },
    { "n", "[FuzzyFinder]<CR>", "<Cmd>WhichKey [FuzzyFinder]<CR>" },
    { "n", "[ufo]<CR>", "<Cmd>WhichKey [ufo]<CR>" },
    { "n", "g<CR>", "<Cmd>WhichKey g<CR>" },
    { "n", "[<CR>", "<Cmd>WhichKey [<CR>" },
    { "n", "]<CR>", "<Cmd>WhichKey ]<CR>" },

    ------------------------------------------------------------
    -- bufferline
    { "n", "<Leader>b", "<Cmd>BufferLinePick<CR>" },
    { "n", "<C-h>", "<Cmd>BufferLineCyclePrev<CR>" },
    { "n", "<C-l>", "<Cmd>BufferLineCycleNext<CR>" },
    { "n", "<<", "<Cmd>BufferLineMovePrev<CR>" },
    { "n", ">>", "<Cmd>BufferLineMoveNext<CR>" },
    { "n", "<C-S-F2>", "<Cmd>BufferLineMovePrev<CR>" },
    { "n", "<C-S-F3>", "<Cmd>BufferLineMoveNext<CR>" },
    { "n", "<Space>1", "<Cmd>BufferLineGoToBuffer 1<CR>" },
    { "n", "<Space>2", "<Cmd>BufferLineGoToBuffer 2<CR>" },
    { "n", "<Space>3", "<Cmd>BufferLineGoToBuffer 3<CR>" },
    { "n", "<Space>4", "<Cmd>BufferLineGoToBuffer 4<CR>" },
    { "n", "<Space>5", "<Cmd>BufferLineGoToBuffer 5<CR>" },
    { "n", "<Space>6", "<Cmd>BufferLineGoToBuffer 6<CR>" },
    { "n", "<Space>7", "<Cmd>BufferLineGoToBuffer 7<CR>" },
    { "n", "<Space>8", "<Cmd>BufferLineGoToBuffer 8<CR>" },
    { "n", "<Space>9", "<Cmd>BufferLineGoToBuffer 9<CR>" },

    ------------------------------------------------------------
    -- bufdelete / no-neck-pain / neo-tree / sidebar / lualine
    {
      "n",
      "<C-q>",
      function()
        require("bufdelete").bufdelete(0, true)
      end,
      { desc = "Delete buffer" },
    },
    { "n", "<C-s>", "<Cmd>Neotree focus<CR>" },
    { "n", "<C-z>", "<Cmd>SidebarNvimToggle<CR>" },
    { "n", "<Leader>wc", "<Cmd>NoNeckPain<CR>" },
    { "n", "<Leader>ul", "<Cmd>lua LualineToggle()<CR>", { desc = "Toggle lualine" } },

    ------------------------------------------------------------
    -- yanky (p / P / gp / gP / y を占有する。<Plug> なので remap 必須)
    { { "n", "x" }, "p", "<Plug>(YankyPutAfter)", { remap = true } },
    { { "n", "x" }, "P", "<Plug>(YankyPutBefore)", { remap = true } },
    { { "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { remap = true } },
    { { "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { remap = true } },
    { { "n", "x" }, "y", "<Plug>(YankyYank)", { remap = true } },

    ------------------------------------------------------------
    -- Comment
    { "n", "<C-_>", "<Cmd>lua require('Comment.api').toggle_current_linewise()<CR>" },
    { "i", "<C-_>", "<Esc>:<C-u>lua require('Comment.api').toggle_current_linewise()<CR>\"_cc" },
    { "v", "<C-_>", "gc", { remap = true } },

    ------------------------------------------------------------
    -- iswap
    { "n", "<Leader>s", "<Cmd>ISwap<CR>" },

    ------------------------------------------------------------
    -- Git
    {
      "n",
      "<C-\\>",
      function()
        require("snacks").lazygit()
      end,
      { desc = "LazyGit" },
    },
    {
      "n",
      "[git]o",
      function()
        require("snacks").gitbrowse({ notify = true })
      end,
      { desc = "Git browse" },
    },
    { "n", "[git]s", "<Cmd>Neogit<CR>", { desc = "Neogit" } },
    { "n", "[git]d", "<Cmd>DiffviewOpen<CR>", { desc = "Diffview" } },

    ------------------------------------------------------------
    -- Octo
    { "n", "[Octo]l", "<Cmd>Octo pr list<CR>" },
    { "n", "[Octo]is", "<Cmd>Octo issue search<CR>" },
    { "n", "[Octo]ib", "<Cmd>Octo issue browser<CR>" },
    { "n", "[Octo]ps", "<Cmd>Octo pr search<CR>" },
    { "n", "[Octo]pn", "<Cmd>Octo pr create<CR>" },
    { "n", "[Octo]pp", "<Cmd>Octo pr draft<CR>" },
    { "n", "[Octo]pb", "<Cmd>Octo pr browser<CR>" },
    { "n", "[Octo]rva", "<Cmd>Octo reviewer add<CR>" },
    { "n", "[Octo]rs", "<Cmd>Octo review start<CR>" },
    { "n", "[Octo]re", "<Cmd>Octo review submit<CR>" },
    { "n", "[Octo]rc", "<Cmd>Octo review comments<CR>" },

    ------------------------------------------------------------
    -- LSP (rc.lsp.locate 経由のジャンプ)
    { "n", "gd", lsp_location("textDocument/definition") },
    { "n", "gD", lsp_location("textDocument/declaration") },
    {
      "n",
      "gr",
      lsp_location("textDocument/references", function(params)
        params.context = { includeDeclaration = true }
      end),
    },
    { "n", "gI", lsp_location("textDocument/implementation") },
    { "n", "gy", lsp_location("textDocument/typeDefinition") },

    ------------------------------------------------------------
    -- Lspsaga (? と [_Lsp]f はバッファローカルの LSP マップが持つ。keymaps/lsp.lua を参照)
    { "n", "[_Lsp]r", "<Cmd>Lspsaga rename<CR>" },
    { { "n", "x" }, "M", "<Cmd>Lspsaga code_action<CR>" },
    { "n", "[_Lsp]j", "<Cmd>Lspsaga diagnostic_jump_next<CR>" },
    { "n", "[_Lsp]k", "<Cmd>Lspsaga diagnostic_jump_prev<CR>" },
    { "n", "[_Lsp]F", "<Cmd>Lspsaga finder<CR>" },
    { "n", "[_Lsp]d", "<Cmd>Lspsaga peek_definition<CR>" },
    { "n", "[_Lsp]o", "<Cmd>Lspsaga outline<CR>" },

    ------------------------------------------------------------
    -- trouble
    { "n", "[_Lsp]xx", "<Cmd>Trouble diagnostics toggle<CR>" },
    { "n", "[_Lsp]xd", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>" },
    { "n", "[_Lsp]xl", "<Cmd>Trouble loclist toggle<CR>" },
    { "n", "[_Lsp]xq", "<Cmd>Trouble qflist toggle<CR>" },

    ------------------------------------------------------------
    -- neogen
    {
      "n",
      "[_Lsp]n",
      function()
        require("neogen").generate()
      end,
      { desc = "Generate annotation" },
    },

    ------------------------------------------------------------
    -- FuzzyFinder (snacks picker)
    {
      "n",
      "<Leader><Leader>",
      function()
        require("snacks").picker.smart({ ignored = true, hidden = true })
      end,
    },
    {
      "n",
      "[FuzzyFinder].",
      function()
        require("snacks").picker.files({ ignored = true, hidden = true })
      end,
    },
    {
      "n",
      "[FuzzyFinder],",
      function()
        require("snacks").picker.buffers({
          unloaded = true,
          current = true,
          sort_lastused = true,
          win = {
            list = { keys = { ["dd"] = "bufdelete" } },
          },
        })
      end,
    },
    {
      "n",
      "[FuzzyFinder]h",
      function()
        require("snacks").picker.search_history()
      end,
    },
    {
      "n",
      "[FuzzyFinder]r",
      function()
        require("snacks").picker.registers()
      end,
    },
    {
      "n",
      "[FuzzyFinder]k",
      function()
        require("snacks").picker.keymaps()
      end,
    },
    {
      "n",
      "[FuzzyFinder]/",
      function()
        require("snacks").picker.grep({ cmd = "rg", regex = true, live = true })
      end,
    },
    {
      "n",
      "[FuzzyFinder]sw",
      function()
        require("snacks").picker.grep_word({ cmd = "rg", live = true })
      end,
    },
    {
      "n",
      "[FuzzyFinder]ss",
      function()
        require("snacks").picker.lsp_symbols({ live = true })
      end,
    },
    {
      "n",
      "[FuzzyFinder]gl",
      function()
        require("snacks").picker.git_log({ live = true })
      end,
    },
    {
      "n",
      "[FuzzyFinder]n",
      function()
        require("snacks").picker.notifications()
      end,
    },
    {
      "n",
      "[FuzzyFinder]m",
      function()
        require("snacks").picker.marks()
      end,
    },
    {
      "n",
      "[FuzzyFinder]p",
      function()
        require("snacks").picker.projects()
      end,
    },
    {
      "n",
      "[FuzzyFinder]sp",
      function()
        require("snacks").picker.spelling()
      end,
    },

    ------------------------------------------------------------
    -- treesitter-unit
    { "x", "iu", ':lua require"treesitter-unit".select()<CR>' },
    { "x", "au", ':lua require"treesitter-unit".select(true)<CR>' },
    { "o", "iu", ':<C-u>lua require"treesitter-unit".select()<CR>' },
    { "o", "au", ':<C-u>lua require"treesitter-unit".select(true)<CR>' },

    ------------------------------------------------------------
    -- nvim-treehopper
    {
      "o",
      "m",
      function()
        require("tsht").nodes()
      end,
      { remap = true },
    },
    { "x", "m", ':lua require("tsht").nodes()<CR>' },

    ------------------------------------------------------------
    -- vim-matchup
    { "o", "%", "]%", { remap = true } },

    ------------------------------------------------------------
    -- vim-asterisk (<Plug> なので remap 必須)
    { "", "g*", "<Plug>(asterisk-z*)", { remap = true } },
    { "", "g#", "<Plug>(asterisk-z#)", { remap = true } },
    { "", "*", "<Plug>(asterisk-gz*)", { remap = true } },

    ------------------------------------------------------------
    -- nvim-ufo
    {
      "n",
      "[ufo]R",
      function()
        require("ufo").openAllFolds()
      end,
      { desc = "Open all folds" },
    },
    {
      "n",
      "[ufo]M",
      function()
        require("ufo").closeAllFolds()
      end,
      { desc = "Close all folds" },
    },
    {
      "n",
      "[ufo]r",
      function()
        require("ufo").openFoldsExceptKinds()
      end,
      { desc = "Open folds except kinds" },
    },
    {
      "n",
      "[ufo]m",
      function()
        require("ufo").closeFoldsWith()
      end,
      { desc = "Close folds with level" },
    },

    ------------------------------------------------------------
    -- skkeleton / LuaSnip (<Plug> なので remap 必須)
    { { "i", "c", "t" }, "<C-j>", "<Plug>(skkeleton-toggle)", { remap = true } },
    { { "i", "s" }, "<C-Down>", "<Plug>luasnip-next-choice", { remap = true } },

    ------------------------------------------------------------
    -- markdown
    { "n", "<Leader>mt", "<Cmd>RenderMarkdown buf_toggle<CR>" },

    ------------------------------------------------------------
    -- AI / Codex
    { "n", "<Leader>co", "<Cmd>Codex<CR>", { desc = "Toggle Codex" } },

    ------------------------------------------------------------
    -- toggleterm
    { "n", "tt", '<Cmd>execute v:count1 . "ToggleTerm direction=horizontal"<CR>' },
    { "n", "tv", '<Cmd>execute v:count1 . "ToggleTerm direction=vertical"<CR>' },
    { "n", "tf", '<Cmd>execute v:count1 . "ToggleTerm direction=float"<CR>' },
    { "n", "tb", '<Cmd>execute v:count1 . "ToggleTerm direction=tab"<CR>' },
  })

  set(treesitter_textobject_maps())

  -- nvim-treesitter-textobjects: パラメータの入れ替え
  set({
    {
      "n",
      "'>",
      function()
        require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
      end,
      { desc = "TS swap next parameter" },
    },
    {
      "n",
      "'<",
      function()
        require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
      end,
      { desc = "TS swap prev parameter" },
    },
  })

  if has_deno() then
    set({
      { "n", "<Leader>mo", "<Cmd>MarkdownOpen<CR>" },
      { "n", "<Leader>mc", "<Cmd>MarkdownClose<CR>" },
    })
  end
end
