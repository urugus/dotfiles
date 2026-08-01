local M = {}

function M.setup()
  local severity = vim.diagnostic.severity
  local icons = {
    [severity.ERROR] = "",
    [severity.WARN] = "",
    [severity.HINT] = "󰛩",
    [severity.INFO] = "",
  }

  vim.diagnostic.config({
    virtual_text = false,
    float = {
      border = "rounded",
      source = true,
    },
    signs = {
      text = icons,
      numhl = {
        [severity.ERROR] = "DiagnosticSignError",
        [severity.WARN] = "DiagnosticSignWarn",
        [severity.HINT] = "DiagnosticSignHint",
        [severity.INFO] = "DiagnosticSignInfo",
      },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })
end

return M
