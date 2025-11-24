local M = {}

function M.setup_autocmd()
  local group_name = "vimrc_lsp_attach"
  vim.api.nvim_create_augroup(group_name, { clear = true })

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      require("rc.keymaps.lsp").apply(client, bufnr)
    end,
    group = group_name,
  })
end

return M
