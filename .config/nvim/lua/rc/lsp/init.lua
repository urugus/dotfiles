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

local function truncate_large_lsp_log()
  local max_size = 10 * 1024 * 1024
  local log_path = vim.lsp.log.get_filename()
  local stat = vim.uv.fs_stat(log_path)

  if stat and stat.size > max_size then
    vim.fn.writefile({}, log_path)
  end
end

function M.setup()
  ensure_state_home()
  vim.lsp.log.set_level(vim.lsp.log.levels.ERROR)
  truncate_large_lsp_log()
  diagnostic.setup()
  attach.setup_autocmd()

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = servers.ensure_installed,
  })

  servers.setup(capabilities.get())
end

return M
