local M = {}

function M.setup()
  local signs = { Error = "", Warn = "", Hint = "󰛩", Info = "" }

  vim.diagnostic.config({
    virtual_text = false,
    float = {
      border = "rounded",
      source = "always",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

return M
