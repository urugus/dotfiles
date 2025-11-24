local diagnostic = require("rc.lsp.diagnostic")
local attach = require("rc.lsp.attach")
local servers = require("rc.lsp.servers")
local capabilities = require("rc.lsp.capabilities")

local M = {}

local function ensure_state_home()
  -- Mason は stdpath("state") を利用する。書き込み不可な場合は一時ディレクトリへ退避。
  local ok = vim.loop.fs_access(vim.fn.stdpath("state"), "W")
  if not ok then
    local fallback = vim.fn.stdpath("data") .. "/mason-state"
    vim.fn.mkdir(fallback, "p")
    vim.env.XDG_STATE_HOME = fallback
  end
end

function M.setup()
  ensure_state_home()
  diagnostic.setup()
  attach.setup_autocmd()

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = servers.ensure_installed,
  })

  servers.setup(capabilities.get())
end

return M
