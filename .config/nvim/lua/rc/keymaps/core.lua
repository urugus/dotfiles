local set = require("rc.keymaps.util").set

return function()
  set({
    -- タブ
    { "n", "<C-t>n", ":tab new<CR>" },

    -- ターミナル
    { "t", "<Esc>", "<C-\\><C-n>", { silent = false } },

    -- カーソル/表示
    { "n", "gzz", "zz" },
    { "n", "gj", "j" },
    { "n", "gk", "k" },
    {
      { "n", "x" },
      "j",
      function()
        return vim.v.count > 0 and "j" or "gj"
      end,
      { expr = true },
    },
    {
      { "n", "x" },
      "k",
      function()
        return vim.v.count > 0 and "k" or "gk"
      end,
      { expr = true },
    },
    { "n", "Q", "<Cmd>tabclose<CR>" },
    { "n", "gq", "<Cmd>nohlsearch<CR>" },

    -- 数値
    { { "n", "x" }, "+", "<C-a>" },
    { { "n", "x" }, "-", "<C-x>" },

    -- ペースト系 (p / P / gp / gP / y は yanky が持つ。plugins.lua を参照)
    { { "n", "x" }, "<LocalLeader>p", '"+p' },
    { { "n", "x" }, "<LocalLeader>P", '"+P' },
  })
end
