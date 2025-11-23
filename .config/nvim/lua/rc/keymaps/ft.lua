local M = {}

function M.setup()
  local group = vim.api.nvim_create_augroup("vimrc_keymaps_ft", { clear = true })

  vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
    group = group,
    pattern = "*",
    callback = function()
      if vim.bo.buftype ~= "prompt" then
        return
      end
      local opts = { noremap = true, silent = true, buffer = true }
      vim.keymap.set("i", "<C-j>", "<Esc><C-w>j", opts)
      vim.keymap.set("i", "<C-k>", "<Esc><C-w>k", opts)
      vim.keymap.set("i", "<C-h>", "<Esc><C-w>h", opts)
      vim.keymap.set("i", "<C-l>", "<Esc><C-w>l", opts)
    end,
  })
end

return M
