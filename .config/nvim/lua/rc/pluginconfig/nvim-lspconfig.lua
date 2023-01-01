local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local status, nvim_lsp = pcall(require, "lspconfig")
local protocol = require('vim.lsp.protocol')
local on_attach = function(client, bufnr)
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.formatting_seq_sync() end
    })
  end
end

-- typescript
vim.lsp.start({
  on_attach = on_attach,
  cmd = { "typescript-language-server", "--stdio" },
  root_dir = vim.fs.dirname(
    vim.fs.find({
      "package.json",
      "tsconfig.json",
      "jsconfig.json",
      ".git",
      "next.config.js",
      'jest.config.js',
    })[1]
  )
})
