require("lazygit").setup({
  terminal_cmd = nil,
  on_open = function()
    vim.cmd("startinsert") -- LazyGit を開いたら自動で挿入モード
  end,
  on_close = function()
    vim.notify("LazyGit を閉じました！", vim.log.levels.INFO) -- メッセージを Neovim の通知システムで表示
  end,
})
require("toggleterm").setup({
  direction = "float",
  on_close = function(term)
    if term.cmd == "lazygit" then
      vim.notify("LazyGit のウィンドウを閉じました！", vim.log.levels.INFO)
    end
  end,
})
