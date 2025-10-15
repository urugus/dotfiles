-- Diagnostic signs configuration
local signs = { Error = "", Warn = "", Hint = "󰛩", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Note: All LSP server configurations are now managed in mason-lspconfig.lua
-- This includes: ts_ls, lua_ls, rust_analyzer, solargraph, terraformls, pyright (Mason-managed)
-- And also: astro, hls (non-Mason managed, configured at the end of mason-lspconfig.lua)
