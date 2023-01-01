vim.g.ale_enabled = 1
vim.g.ale_set_highlights = 1
vim.g.ale_send_to_neovim_diagnostics = 1

-- don't use the custom LSP client in ALE, I'm using the native one in NeoVim
-- nvim-ale-diagnostic is what glues the two together
vim.g.ale_disable_lsp = 1

-- prettier signs
vim.g.ale_sign_error = ""
vim.g.ale_sign_warning = ""
vim.g.ale_sign_info = ""
vim.g.ale_sign_style_error = ""
vim.g.ale_sign_style_warning = ""
vim.g.ale_echo_msg_error_str = 'E'
vim.g.ale_echo_msg_warning_str = 'W'
vim.g.ale_sign_column_always = 1
vim.g.ale_set_signs = 1

-- use a floating window to show the lint problems
vim.g.ale_floating_preview = 1
vim.g.ale_floating_window_border = { '│', '─', '╭', '╮', '╯', '╰', '│', '─' }
vim.g.ale_hover_cursor = 1

-- don't run the linter(s) for this file when I edit text, live, instead only
-- do so when I leave insert mode
vim.g.ale_lint_on_text_changed = 1
vim.g.ale_lint_on_insert_leave = 1

-- echo a message whenever my cursor moves to a line with a problem
vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
vim.g.ale_echo_cursor = 1
-- if there's an ALE preview window open, close it when I enter insert mode
vim.g.ale_close_preview_on_insert = 1

-- customize the linters
vim.g.ale_yaml_yamllint_options = '-f ' .. vim.fn.stdpath("config") .. "/linters/yamllint.yml"

-- fixers
vim.g.ale_fix_on_save = 1
vim.g.ale_fixers = {
  -- ruby
  ruby = { "rubocop" },
  -- javascript
  typescript = { "prettier", "eslint" },
  javascript = { "prettier", "eslint" },
  javascriptreact = { "prettier", "eslint" },
  css = { "prettier", "eslint" },
  scss = { "prettier", "eslint" },
  -- lua
  lua  = { "lua-format" },
}

-- linters
vim.g.ale_linters_explicit = 1
vim.g.ale_linters = {
  ruby = { "rubocop" },
  -- javascript
  typescript = { "prettier", "eslint" },
  javascript = { "prettier", "eslint" },
  javascriptreact = { "prettier", "eslint" },
  css = { "prettier", "eslint" },
  scss = { "prettier", "eslint" },
  -- lua
  lua  = { "lua-format" },
}


-- --------------------------------------------------------
-- language settings

-- --------------------------------
-- ruby
vim.g.ale_ruby_rubocop_executable = 'bundle'
vim.g.ale_ruby_rubocop_options = '-D'

-- --------------------------------
-- typescript
vim.g.ale_javascript_prettier_use_local_config = 1
