local set = require("rc.keymaps.util").set

return function()
  set({
    -- プレフィックス
    { "n", "[_Lsp]", "<Nop>", { noremap = true, silent = true } },
    { "n", "<Leader>l", "[_Lsp]", { noremap = true, silent = true, desc = "LSP prefix" } },

    { "n", "[Copilot]", "<Nop>", { noremap = true, silent = true } },
    { "n", "<Leader>c", "[Copilot]", { noremap = true, silent = true, desc = "Copilot prefix" } },

    { "n", "[git]", "<Nop>", { noremap = true, silent = true } },
    { "n", "<Leader>g", "[git]", { noremap = true, silent = true, desc = "Git prefix" } },

    { "n", "[Octo]", "<Nop>", { noremap = true, silent = true } },
    { "n", "<Leader>gg", "[Octo]", { noremap = true, silent = true, desc = "Octo prefix" } },
    { "v", "<Leader>gg", "[Octo]", { noremap = true, silent = true, desc = "Octo prefix" } },

    { "n", "[FuzzyFinder]", "<Nop>", { noremap = true, silent = true } },
    { "v", "[FuzzyFinder]", "<Nop>", { noremap = true, silent = true } },
    { "n", "<Leader>f", "[FuzzyFinder]", { noremap = true, silent = true, desc = "Finder prefix" } },
    { "v", "<Leader>f", "[FuzzyFinder]", { noremap = true, silent = true, desc = "Finder prefix" } },

    ------------------------------------------------------------
    -- Bufferline
    { "n", "<Leader>b", "<Cmd>BufferLinePick<CR>", { noremap = true, silent = true, plugin = "bufferline.nvim" } },
    { "n", "<C-h>", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true, plugin = "bufferline.nvim" } },
    { "n", "<C-l>", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true, plugin = "bufferline.nvim" } },
    { "n", "<<", "<Cmd>BufferLineMovePrev<CR>", { noremap = true, silent = true, plugin = "bufferline.nvim" } },
    { "n", ">>", "<Cmd>BufferLineMoveNext<CR>", { noremap = true, silent = true, plugin = "bufferline.nvim" } },
    { "n", "<C-S-F2>", "<Cmd>BufferLineMovePrev<CR>", { noremap = true, silent = true, plugin = "bufferline.nvim" } },
    { "n", "<C-S-F3>", "<Cmd>BufferLineMoveNext<CR>", { noremap = true, silent = true, plugin = "bufferline.nvim" } },
    {
      "n",
      "<Space>1",
      "<Cmd>BufferLineGoToBuffer 1<CR>",
      { noremap = true, silent = true, plugin = "bufferline.nvim" },
    },
    {
      "n",
      "<Space>2",
      "<Cmd>BufferLineGoToBuffer 2<CR>",
      { noremap = true, silent = true, plugin = "bufferline.nvim" },
    },
    {
      "n",
      "<Space>3",
      "<Cmd>BufferLineGoToBuffer 3<CR>",
      { noremap = true, silent = true, plugin = "bufferline.nvim" },
    },
    {
      "n",
      "<Space>4",
      "<Cmd>BufferLineGoToBuffer 4<CR>",
      { noremap = true, silent = true, plugin = "bufferline.nvim" },
    },
    {
      "n",
      "<Space>5",
      "<Cmd>BufferLineGoToBuffer 5<CR>",
      { noremap = true, silent = true, plugin = "bufferline.nvim" },
    },
    {
      "n",
      "<Space>6",
      "<Cmd>BufferLineGoToBuffer 6<CR>",
      { noremap = true, silent = true, plugin = "bufferline.nvim" },
    },
    {
      "n",
      "<Space>7",
      "<Cmd>BufferLineGoToBuffer 7<CR>",
      { noremap = true, silent = true, plugin = "bufferline.nvim" },
    },
    {
      "n",
      "<Space>8",
      "<Cmd>BufferLineGoToBuffer 8<CR>",
      { noremap = true, silent = true, plugin = "bufferline.nvim" },
    },
    {
      "n",
      "<Space>9",
      "<Cmd>BufferLineGoToBuffer 9<CR>",
      { noremap = true, silent = true, plugin = "bufferline.nvim" },
    },

    ------------------------------------------------------------
    -- Git / Octo
    {
      "n",
      "<C-g>",
      function()
        require("snacks").lazygit()
      end,
      { noremap = true, silent = true, desc = "LazyGit", plugin = "snacks.nvim" },
    },
    {
      "n",
      "[git]o",
      function()
        require("snacks").gitbrowse({ notify = true })
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    { "n", "[Octo]l", "<Cmd>Octo pr list<Cr>", { silent = true, noremap = true, plugin = "octo.nvim" } },
    { "n", "[Octo]is", "<Cmd>Octo issue search<Cr>", { silent = true, noremap = true, plugin = "octo.nvim" } },
    { "n", "[Octo]ib", "<Cmd>Octo issue browser<Cr>", { silent = true, noremap = true, plugin = "octo.nvim" } },
    { "n", "[Octo]ps", "<Cmd>Octo pr search<Cr>", { silent = true, noremap = true, plugin = "octo.nvim" } },
    { "n", "[Octo]pn", "<Cmd>Octo pr create<Cr>", { silent = true, noremap = true, plugin = "octo.nvim" } },
    { "n", "[Octo]pp", "<Cmd>Octo pr draft<Cr>", { silent = true, noremap = true, plugin = "octo.nvim" } },
    { "n", "[Octo]pb", "<Cmd>Octo pr browser<Cr>", { silent = true, noremap = true, plugin = "octo.nvim" } },
    { "n", "[Octo]rva", "<Cmd>Octo reviewer add<Cr>", { silent = true, noremap = true, plugin = "octo.nvim" } },
    { "n", "[Octo]rs", "<Cmd>Octo review start<Cr>", { silent = true, noremap = true, plugin = "octo.nvim" } },
    { "n", "[Octo]re", "<Cmd>Octo review submit<Cr>", { silent = true, noremap = true, plugin = "octo.nvim" } },
    { "n", "[Octo]rc", "<Cmd>Octo review comments<Cr>", { silent = true, noremap = true, plugin = "octo.nvim" } },

    ------------------------------------------------------------
    -- LSP (Snacks picker)
    {
      "n",
      "gd",
      function()
        require("snacks").picker.lsp_definitions()
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "gD",
      function()
        require("snacks").picker.lsp_declarations()
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "gr",
      function()
        require("snacks").picker.lsp_references()
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "gI",
      function()
        require("snacks").picker.lsp_implementations()
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "gy",
      function()
        require("snacks").picker.lsp_type_definitions()
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },

    ------------------------------------------------------------
    -- FuzzyFinder (Snacks picker)
    {
      "n",
      "<Leader><Leader>",
      function()
        require("snacks").picker.smart({ ignored = true, hidden = true })
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "[FuzzyFinder].",
      function()
        require("snacks").picker.files({ ignored = true, hidden = true })
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
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
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "[FuzzyFinder]h",
      function()
        require("snacks").picker.search_history()
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "[FuzzyFinder]r",
      function()
        require("snacks").picker.registers()
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "[FuzzyFinder]k",
      function()
        require("snacks").picker.keymaps()
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "[FuzzyFinder]/",
      function()
        require("snacks").picker.grep({ cmd = "rg", regex = true, live = true })
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "[FuzzyFinder]sw",
      function()
        require("snacks").picker.grep_word({ cmd = "rg", live = true })
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "[FuzzyFinder]ss",
      function()
        require("snacks").picker.lsp_symbols({ live = true })
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "[FuzzyFinder]gl",
      function()
        require("snacks").picker.git_log({ live = true })
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "[FuzzyFinder]n",
      function()
        require("snacks").picker.notifications()
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "[FuzzyFinder]m",
      function()
        require("snacks").picker.marks()
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "[FuzzyFinder]p",
      function()
        require("snacks").picker.projects()
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },
    {
      "n",
      "[FuzzyFinder]sp",
      function()
        require("snacks").picker.spelling()
      end,
      { noremap = true, silent = true, plugin = "snacks.nvim" },
    },

    ------------------------------------------------------------
    -- Markdown
    { "n", "<Leader>mo", "<Cmd>MarkdownOpen<CR>", { noremap = true, silent = true } },
    { "n", "<Leader>mc", "<Cmd>MarkdownClose<CR>", { noremap = true, silent = true } },

    ------------------------------------------------------------
    -- Window
    { "n", "<C-s>", "<Cmd>Neotree focus<CR>", { noremap = true, silent = true, plugin = "neo-tree.nvim" } },
    { "n", "<Leader>wc", "<Cmd>NoNeckPain<CR>", { noremap = true, silent = true, plugin = "no-neck-pain.nvim" } },

    ------------------------------------------------------------
    -- AI / Codex
    {
      "n",
      "<leader>co",
      "<Cmd>Codex<CR>",
      { noremap = true, silent = true, desc = "Toggle Codex", plugin = "codex.nvim" },
    },

    ------------------------------------------------------------
    -- Lspsaga
    { "n", "[_Lsp]r", "<cmd>Lspsaga rename<cr>", { silent = true, noremap = true, plugin = "lspsaga.nvim" } },
    { "n", "M", "<cmd>Lspsaga code_action<cr>", { silent = true, noremap = true, plugin = "lspsaga.nvim" } },
    { "x", "M", ":<c-u>Lspsaga range_code_action<cr>", { silent = true, noremap = true, plugin = "lspsaga.nvim" } },
    { "n", "?", "<cmd>Lspsaga hover_doc<cr>", { silent = true, noremap = true, plugin = "lspsaga.nvim" } },
    {
      "n",
      "[_Lsp]j",
      "<cmd>Lspsaga diagnostic_jump_next<cr>",
      { silent = true, noremap = true, plugin = "lspsaga.nvim" },
    },
    {
      "n",
      "[_Lsp]k",
      "<cmd>Lspsaga diagnostic_jump_prev<cr>",
      { silent = true, noremap = true, plugin = "lspsaga.nvim" },
    },
    { "n", "[_Lsp]f", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true, plugin = "lspsaga.nvim" } },
    { "n", "[_Lsp]s", "<Cmd>Lspsaga signature_help<CR>", { silent = true, noremap = true, plugin = "lspsaga.nvim" } },
    {
      "n",
      "[_Lsp]d",
      "<cmd>Lspsaga preview_definition<CR>",
      { silent = true, noremap = true, plugin = "lspsaga.nvim" },
    },
    { "n", "[_Lsp]o", "<cmd>LSoutlineToggle<CR>", { silent = true, noremap = true, plugin = "lspsaga.nvim" } },

    ------------------------------------------------------------
    -- nvim-test
    { "n", "<Space>ta", "<Cmd>TestFile<CR>", { noremap = true, silent = true, plugin = "nvim-test" } },
    { "n", "<Space>te", "<Cmd>TestEdit<CR>", { noremap = true, silent = true, plugin = "nvim-test" } },
    { "n", "<Space>tl", "<Cmd>TestNearest<CR>", { noremap = true, silent = true, plugin = "nvim-test" } },

    ------------------------------------------------------------
    -- neogen
    { "n", "gca", "<Cmd>lua require('neogen').generate()<CR>", { noremap = true, silent = true, plugin = "neogen" } },

    ------------------------------------------------------------
    -- copilot.lua
    {
      "i",
      "<C-c>e",
      function()
        pcall(function()
          require("cmp").mapping.abort()
        end)
        pcall(function()
          require("copilot.suggestion").accept()
        end)
      end,
      { desc = "[copilot] accept suggestion", silent = true, plugin = "copilot.lua" },
    },

    ------------------------------------------------------------
    -- nvim-treehopper
    {
      { "o" },
      "m",
      function()
        require("tsht").nodes()
      end,
      { noremap = false, expr = false, silent = true, plugin = "nvim-treehopper" },
    },
    {
      { "x" },
      "m",
      ":lua require('tsht').nodes()<CR>",
      { noremap = true, expr = false, silent = true, plugin = "nvim-treehopper" },
    },

    ------------------------------------------------------------
    -- nvim-ufo
    {
      "n",
      "[ufo]R",
      function()
        require("ufo").openAllFolds()
      end,
      { desc = "Open all folds", plugin = "nvim-ufo" },
    },
    {
      "n",
      "[ufo]M",
      function()
        require("ufo").closeAllFolds()
      end,
      { desc = "Close all folds", plugin = "nvim-ufo" },
    },
    {
      "n",
      "[ufo]r",
      function()
        require("ufo").openFoldsExceptKinds()
      end,
      { desc = "Open folds except kinds", plugin = "nvim-ufo" },
    },
    {
      "n",
      "[ufo]m",
      function()
        require("ufo").closeFoldsWith()
      end,
      { desc = "Close folds with level", plugin = "nvim-ufo" },
    },

    ------------------------------------------------------------
    -- toggleterm (global mappingsのみ)
    {
      "n",
      "tt",
      '<Cmd>execute v:count1 . "ToggleTerm direction=horizontal"<CR>',
      { noremap = true, silent = true, plugin = "toggleterm.nvim" },
    },
    {
      "n",
      "tv",
      '<Cmd>execute v:count1 . "ToggleTerm direction=vertical"<CR>',
      { noremap = true, silent = true, plugin = "toggleterm.nvim" },
    },
    {
      "n",
      "tf",
      '<Cmd>execute v:count1 . "ToggleTerm direction=float"<CR>',
      { noremap = true, silent = true, plugin = "toggleterm.nvim" },
    },
    {
      "n",
      "tb",
      '<Cmd>execute v:count1 . "ToggleTerm direction=tab"<CR>',
      { noremap = true, silent = true, plugin = "toggleterm.nvim" },
    },
  })
end
