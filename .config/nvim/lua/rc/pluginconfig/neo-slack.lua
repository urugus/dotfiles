vim.schedule(function()
  require("neo-slack").setup({
    default_channel = "general",
    refresh_interval = 30, -- メッセージ更新間隔（秒）
    notification = true, -- 通知を有効にする
    keymaps = {
      toggle = "<leader>ss",
      channels = "<leader>sc",
      messages = "<leader>sm",
      reply = "<leader>sr",
      react = "<leader>se",
    },
  })
end)
