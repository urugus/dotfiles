require("rc/base")

-- ===============================

require("rc/option")
require("rc/display")
require("rc/pluginlist")
require("rc/mappings")
require("rc/command")
require("rc/autocmd")

-- Configuration
vim.api.nvim_exec(
	[[
for f in split(glob('~/.config/nvim/rc/myplugins/*.vim'), '\n')
  execute 'source ' . f
endfor
]],
	true
)

vim.schedule(function()
	for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/rc/myplugins/opt", [[v:val =~ '\.lua$']])) do
		require("rc/myplugins/opt/" .. file:gsub("%.lua$", ""))
	end
end)

-- ===============================

-- Local Configuration
if vim.fn.filereadable(vim.fn.expand("~/.nvim_local_init.lua")) ~= 0 then
	dofile(vim.fn.expand("~/.nvim_local_init.lua"))
end

-- Editor Configuration
if vim.fn.exists("g:neovide") then
  vim.g.neovide_transparency = 0.7
  vim.g.neovide_input_use_logo = true
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
end
