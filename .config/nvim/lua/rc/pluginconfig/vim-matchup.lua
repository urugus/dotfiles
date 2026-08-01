-- キーマップ (o %) は rc/keymaps/plugins.lua にある
vim.g.loaded_matchit = 1
vim.g.matchup_motion_enabled = 1
vim.g.matchup_text_obj_enabled = 1
vim.g.matchup_matchparen_deferred_show_delay = 300
vim.g.matchup_delim_start_plaintext = 0
vim.g.matchup_delim_end_plaintext = 0

vim.api.nvim_set_hl(0, "MatchParenCur", { underline = true, cterm = { underline = true } })
vim.api.nvim_set_hl(0, "MatchWordCur", { underline = true, cterm = { underline = true } })

-- 入力中のハイライト更新は重いので無効化する
vim.api.nvim_clear_autocmds({
  event = { "TextChangedI", "TextChangedP", "TextChanged" },
  group = "matchup_matchparen",
})
