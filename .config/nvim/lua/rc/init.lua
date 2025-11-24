local M = {}

local function load_local_configs()
  -- Vimscript plugin fragments under rc/myplugins/*.vim
  vim.cmd([[
for f in split(glob('~/.config/nvim/rc/myplugins/*.vim'), '\n')
  execute 'source ' . f
endfor
]])

  -- Optional Lua add-ons under rc/myplugins/opt/*.lua (lazy-loaded)
  vim.schedule(function()
    local opt_dir = vim.fn.stdpath("config") .. "/lua/rc/myplugins/opt"
    for _, file in ipairs(vim.fn.readdir(opt_dir, [[v:val =~ '\.lua$']])) do
      require("rc/myplugins/opt/" .. file:gsub("%.lua$", ""))
    end
  end)

  -- Host-local overrides
  local local_init = vim.fn.expand("~/.nvim_local_init.lua")
  if vim.fn.filereadable(local_init) ~= 0 then
    dofile(local_init)
  end
end

function M.setup()
  -- core → plugins → ui → automation → local overrides
  require("rc.core").setup()
  require("rc.plugins").setup()
  require("rc.ui").setup()
  require("rc.automation").setup()
  load_local_configs()
end

return M
