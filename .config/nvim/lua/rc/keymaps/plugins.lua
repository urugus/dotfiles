local set = require("rc.keymaps.util").set

local function snake_case(value)
  return value:gsub("::", "/"):gsub("([A-Z]+)([A-Z][a-z])", "%1_%2"):gsub("([a-z%d])([A-Z])", "%1_%2"):lower()
end

local function lsp_location_uri(location)
  return location.uri or location.targetUri
end

local function lsp_location_path(location)
  local uri = lsp_location_uri(location)
  return uri and vim.uri_to_fname(uri) or nil
end

local function best_lsp_location(result)
  if not result then
    return nil
  end
  if result.uri or result.targetUri then
    return result
  end

  local symbol_path = snake_case(vim.fn.expand("<cword>")) .. ".rb"
  for _, location in ipairs(result) do
    local path = lsp_location_path(location)
    if path and path:sub(-#symbol_path) == symbol_path then
      return location
    end
  end

  return result[1]
end

local function jump_to_lsp_location(location, client_id)
  local client = vim.lsp.get_client_by_id(client_id)
  local offset_encoding = client and client.offset_encoding or "utf-16"

  if location.targetUri then
    location = {
      uri = location.targetUri,
      range = location.targetSelectionRange or location.targetRange,
    }
  end

  vim.lsp.util.jump_to_location(location, offset_encoding, true)
end

local function lsp_location(method, extend_params)
  return function()
    local clients = vim.tbl_filter(function(client)
      return client:supports_method(method, 0)
    end, vim.lsp.get_clients({ bufnr = 0 }))
    local client = clients[1]
    if not client then
      return
    end

    local offset_encoding = client and client.offset_encoding or "utf-16"
    local params = vim.lsp.util.make_position_params(0, offset_encoding)
    local jumped = false

    if extend_params then
      extend_params(params)
    end

    for _, lsp_client in ipairs(clients) do
      lsp_client:request(method, params, function(err, result, ctx)
        if jumped or err then
          return
        end

        local location = best_lsp_location(result)
        if not location then
          return
        end

        jumped = true
        jump_to_lsp_location(location, ctx.client_id)
      end, 0)
    end
  end
end

return function()
  set({
    -- プレフィックス
    { "n", "[_Lsp]", "<Nop>", { noremap = true, silent = true } },
    { "n", "<Leader>l", "[_Lsp]", { remap = true, silent = true, desc = "LSP prefix" } },

    { "n", "[Copilot]", "<Nop>", { noremap = true, silent = true } },
    { "n", "<Leader>c", "[Copilot]", { remap = true, silent = true, desc = "Copilot prefix" } },

    { "n", "[git]", "<Nop>", { noremap = true, silent = true } },
    { "n", "<Leader>g", "[git]", { remap = true, silent = true, desc = "Git prefix" } },

    { "n", "[Octo]", "<Nop>", { noremap = true, silent = true } },
    { "n", "<Leader>gg", "[Octo]", { remap = true, silent = true, desc = "Octo prefix" } },
    { "v", "<Leader>gg", "[Octo]", { remap = true, silent = true, desc = "Octo prefix" } },

    { "n", "[FuzzyFinder]", "<Nop>", { noremap = true, silent = true } },
    { "v", "[FuzzyFinder]", "<Nop>", { noremap = true, silent = true } },
    { "n", "<Leader>f", "[FuzzyFinder]", { remap = true, silent = true, desc = "Finder prefix" } },
    { "v", "<Leader>f", "[FuzzyFinder]", { remap = true, silent = true, desc = "Finder prefix" } },

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
      "<C-\\>",
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
    -- LSP
    {
      "n",
      "gd",
      lsp_location("textDocument/definition"),
      { noremap = true, silent = true },
    },
    {
      "n",
      "gD",
      lsp_location("textDocument/declaration"),
      { noremap = true, silent = true },
    },
    {
      "n",
      "gr",
      lsp_location("textDocument/references", function(params)
        params.context = { includeDeclaration = true }
      end),
      { noremap = true, silent = true },
    },
    {
      "n",
      "gI",
      lsp_location("textDocument/implementation"),
      { noremap = true, silent = true },
    },
    {
      "n",
      "gy",
      lsp_location("textDocument/typeDefinition"),
      { noremap = true, silent = true },
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
    {
      "n",
      "<Leader>mo",
      "<Cmd>MarkdownOpen<CR>",
      { noremap = true, silent = true, plugin = "peek.nvim" },
    },
    {
      "n",
      "<Leader>mc",
      "<Cmd>MarkdownClose<CR>",
      { noremap = true, silent = true, plugin = "peek.nvim" },
    },
    {
      "n",
      "<Leader>mt",
      "<Cmd>RenderMarkdown buf_toggle<CR>",
      { noremap = true, silent = true, plugin = "render-markdown.nvim" },
    },

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
      "o",
      "m",
      function()
        require("tsht").nodes()
      end,
      { noremap = false, expr = false, silent = true, plugin = "nvim-treehopper" },
    },
    {
      "x",
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
    -- skkeleton
    { "i", "<C-j>", "<Plug>(skkeleton-toggle)", { silent = true, plugin = "skkeleton" } },
    { "c", "<C-j>", "<Plug>(skkeleton-toggle)", { silent = true, plugin = "skkeleton" } },

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
