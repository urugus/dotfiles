local conf = require("rc.plugins.shared").conf

return {
  -- Yank / registers
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/yanky"),
  },

  -- Search / filer
  {
    "haya14busa/vim-asterisk",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/vim-asterisk"),
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/nvim-hlslens"),
  },

  -- Treesitter & text objects
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = conf("rc/pluginconfig/nvim-treesitter"),
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "RRethy/nvim-treesitter-endwise",
    lazy = true,
    event = "InsertEnter",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/nvim-treesitter-textobjects"),
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = true,
    main = "various-textobjs",
    opts = { useDefaultKeymaps = false },
  },
  {
    "mizlan/iswap.nvim",
    event = "VeryLazy",
  },
  {
    "mfussenegger/nvim-treehopper",
    event = "VeryLazy",
  },
  {
    "David-Kunz/treesitter-unit",
    event = "VeryLazy",
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
    opts = {},
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
    config = conf("rc/pluginconfig/vim-matchup"),
  },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    opts = { map_cr = false },
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
}
