require("nvim-treesitter").setup({})

-- Install parsers (async, no-op if already installed)
local parsers = {
  "astro",
  "bash",
  "css",
  "html",
  "lua",
  "markdown",
  "python",
  "ruby",
  "tsx",
  "typescript",
}

local installed = require("nvim-treesitter").installed()
local missing = vim.tbl_filter(function(p)
  return not vim.tbl_contains(installed, p)
end, parsers)

if #missing > 0 then
  require("nvim-treesitter").install(missing)
end

-- Enable treesitter highlighting via Neovim built-in API
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter-highlight", { clear = true }),
  callback = function(args)
    if pcall(vim.treesitter.start, args.buf) then
      -- Disable legacy regex highlighting when treesitter is active
      vim.bo[args.buf].syntax = ""
    end
  end,
})
