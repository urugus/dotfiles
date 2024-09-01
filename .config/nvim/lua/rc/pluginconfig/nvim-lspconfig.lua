local signs = { Error = "", Warn = "", Hint = "󰛩", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- typescript
local lspconfig = require("lspconfig")
lspconfig.tsserver.setup({
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
})


-- ruby
lspconfig.solargraph.setup({
  cmd = { "solargraph", "stdio" },
  filetypes = { "ruby" }
})
