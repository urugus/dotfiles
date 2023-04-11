-- vim.g.nvim_ghost_server_port = 5001
vim.cmd([[
  augroup nvim_ghost_user_autocommands
    autocmd User *github.com setfiletype markdown
    autocmd User *openai.com setfiletype markdown
  augroup END
]])
