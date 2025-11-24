local diagnostic = require("rc.lsp.diagnostic")
local attach = require("rc.lsp.attach")
local servers = require("rc.lsp.servers")
local capabilities = require("rc.lsp.capabilities")

local M = {}

function M.setup()
  diagnostic.setup()
  attach.setup_autocmd()

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = servers.ensure_installed,
  })

  servers.setup(capabilities.get())
end

return M
