local M = {}

-- LSP アタッチ時にのみ貼るキーマップ
function M.apply(client, bufnr)
  if client and client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    opts.noremap = opts.noremap ~= false
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  map("n", "?", vim.lsp.buf.hover)
  map("n", "g?", vim.lsp.buf.signature_help)
  map("n", "[_Lsp]wa", vim.lsp.buf.add_workspace_folder)
  map("n", "[_Lsp]wr", vim.lsp.buf.remove_workspace_folder)
  map("n", "[_Lsp]wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end)
  map("n", "[_Lsp]a", vim.lsp.buf.code_action)
  map("n", "[_Lsp]e", vim.diagnostic.open_float)
  map("n", "[d", vim.diagnostic.goto_prev)
  map("n", "]d", vim.diagnostic.goto_next)
  map("n", "[_Lsp]q", vim.diagnostic.setloclist)
  map("n", "[_Lsp]f", vim.lsp.buf.format)
end

return M
