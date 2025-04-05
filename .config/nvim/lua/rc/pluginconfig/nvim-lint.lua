require('lint').linters_by_ft = {
  lua = { 'selene', },
  sh = { 'shellcheck', },
  bash = { 'shellcheck', },
  zsh = { 'shellcheck', },
  javascript = { 'eslint_d' },
  typescript = { 'eslint_d' },
  python = { "flake8" },
  ruby = { 'rubocop' },
  rust = { 'clippy', },
  terraform = { 'tflint', }
}
require("lint").try_lint()

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
callback = function()
  require("lint").try_lint()
end,
})
