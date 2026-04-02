local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  -- Supply-chain hardening: pin to a specific commit instead of --branch=stable
  -- Commit from lazy-lock.json; update both when upgrading lazy.nvim
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--single-branch", lazyrepo, lazypath })
  if vim.v.shell_error == 0 then
    local co_out = vim.fn.system({ "git", "-C", lazypath, "checkout", "306a05526ada86a7b30af95c5cc81ffba93fef97" })
    if vim.v.shell_error ~= 0 then
      out = co_out
    end
  end
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to install lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local lazy_opts = {
  defaults = { lazy = true },
  checker = { enabled = false },
  performance = {
    cache = { enabled = true },
    profiling = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip",
        "man",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

local specs = {}
for _, mod in ipairs({
  "rc.plugins.ui",
  "rc.plugins.editing",
  "rc.plugins.lsp",
  "rc.plugins.tools",
}) do
  vim.list_extend(specs, require(mod))
end

local M = {}

function M.setup()
  require("lazy").setup(specs, lazy_opts)
end

return M
