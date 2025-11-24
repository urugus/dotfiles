local shared = require("rc.plugins.shared")
local conf = shared.conf
local source = shared.source

return {
  -- Yank / registers
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/yanky"),
  },
  {
    "tversteeg/registers.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/registers"),
  },

  -- Search / filer
  {
    "haya14busa/vim-asterisk",
    event = "VeryLazy",
    config = source("~/.config/nvim/rc/pluginconfig/vim-asterisk.vim"),
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/nvim-hlslens"),
  },

  -- Treesitter & text objects
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "VeryLazy" },
    build = ":TSUpdateSync",
    config = conf("rc/pluginconfig/nvim-treesitter"),
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  { "nvim-treesitter/nvim-treesitter-refactor", lazy = true },
  { "nvim-treesitter/nvim-tree-docs", lazy = true },
  { "yioneko/nvim-yati", lazy = true },
  {
    "RRethy/nvim-treesitter-endwise",
    lazy = true,
    event = "InsertEnter",
    config = conf("rc/pluginconfig/nvim-treesitter-endwise"),
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = true,
    config = conf("rc/pluginconfig/nvim-various-textobjs"),
  },
  {
    "mizlan/iswap.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/iswap"),
  },
  {
    "mfussenegger/nvim-treehopper",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/nvim-treehopper"),
  },
  {
    "David-Kunz/treesitter-unit",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/treesitter-unit"),
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local buf = vim.api.nvim_get_current_buf()
      local name = vim.api.nvim_buf_get_name(buf)
      -- 未変更かつファイル名があるバッファのみリロードして再ハイライト
      -- 変更中や無名バッファはプラグインが自動でハイライトするため何もしない
      if name ~= "" and not vim.bo[buf].modified then
        vim.cmd.edit()
      end
    end,
  },
  {
    "m-demare/hlargs.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/hlargs"),
  },
  {
    "romgrk/nvim-treesitter-context",
    cmd = { "TSContextEnable" },
    config = conf("rc/pluginconfig/treesitter-context"),
  },

  -- Text objects / surround
  {
    "andymass/vim-matchup",
    event = "VeryLazy",
    config = source("~/.config/nvim/rc/pluginconfig/vim-matchup.vim"),
  },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/nvim-autopairs"),
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/nvim-surround"),
  },
}
