local set = require("rc.keymaps.util").set

return function()
  set({
    -- タブ
    { "n", "<C-t>n", ":tab new<CR>", { noremap = true, silent = true } },

    -- ターミナル
    { "t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = false } },

    -- sandwich 占有を解除
    { { "n", "x" }, "s", "<Nop>", { noremap = true, silent = true } },
    { { "n", "x" }, "S", "<Nop>", { noremap = true, silent = true } },

    -- カーソル/表示
    { "n", "gzz", "zz", { noremap = true, silent = true } },
    { "n", "gj", "j", { noremap = true, silent = true } },
    { "n", "gk", "k", { noremap = true, silent = true } },
    {
      { "n", "x" },
      "j",
      function()
        return vim.v.count > 0 and "j" or "gj"
      end,
      { noremap = true, expr = true },
    },
    {
      { "n", "x" },
      "k",
      function()
        return vim.v.count > 0 and "k" or "gk"
      end,
      { noremap = true, expr = true },
    },
    { "n", "Q", "<Cmd>tabclose<CR>", { noremap = true, silent = true } },
    { "n", "gq", "<Cmd>nohlsearch<CR>", { noremap = true, silent = true } },

    -- 数値
    { { "n", "x" }, "+", "<C-a>", { noremap = true, silent = true } },
    { { "n", "x" }, "-", "<C-x>", { noremap = true, silent = true } },

    -- ペースト系
    { { "n", "x" }, "p", "]p", { noremap = true, silent = true } },
    { { "n", "x" }, "gp", "p", { noremap = true, silent = true } },
    { { "n", "x" }, "gP", "P", { noremap = true, silent = true } },
    { { "n", "x" }, "<LocalLeader>p", '"+p', { noremap = true, silent = true } },
    { { "n", "x" }, "<LocalLeader>P", '"+P', { noremap = true, silent = true } },
  })
end
