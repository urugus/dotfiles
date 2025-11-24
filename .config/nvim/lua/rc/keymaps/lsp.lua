local set_buf = require("rc.keymaps.util").set_buf

local M = {}

-- LSP アタッチ時のバッファローカルマップ
function M.apply(client, bufnr)
  if client and client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  set_buf(bufnr, {
    { "n", "?", vim.lsp.buf.hover },
    { "n", "g?", vim.lsp.buf.signature_help },
    { "n", "[_Lsp]wa", vim.lsp.buf.add_workspace_folder },
    { "n", "[_Lsp]wr", vim.lsp.buf.remove_workspace_folder },
    {
      "n",
      "[_Lsp]wl",
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
    },
    { "n", "[_Lsp]a", vim.lsp.buf.code_action },
    { "n", "[_Lsp]e", vim.diagnostic.open_float },
    { "n", "[d", vim.diagnostic.goto_prev },
    { "n", "]d", vim.diagnostic.goto_next },
    { "n", "[_Lsp]q", vim.diagnostic.setloclist },
    { "n", "[_Lsp]f", vim.lsp.buf.format },
  })
end

return M
