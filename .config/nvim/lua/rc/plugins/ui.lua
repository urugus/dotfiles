local shared = require("rc.plugins.shared")
local conf = shared.conf

return {
  -- Color scheme, fonts, animation
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = conf("rc/pluginconfig/vscode"),
  },
  {
    "kyazdani42/nvim-web-devicons",
    lazy = true,
    enabled = function()
      return not os.getenv("DISABLE_DEVICONS") or os.getenv("DISABLE_DEVICONS") == "false"
    end,
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    config = conf("rc/pluginconfig/snacks"),
  },

  -- Layout / visual aids
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/indent-blankline"),
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/Comment"),
  },
  {
    "xiyaowong/nvim-cursorword",
    event = { "BufReadPre", "BufNewFile" },
    config = conf("rc/pluginconfig/nvim-cursorword"),
  },
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    init = function()
      vim.g.Illuminate_delay = 300
    end,
  },
  {
    -- norcalli/nvim-colorizer.lua は未メンテで、0.13 の vim.tbl_flatten 削除で壊れる
    "catgoose/nvim-colorizer.lua",
    event = "VeryLazy",
    opts = {}, -- filetypes は既定で { "*" }
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "mvllow/modes.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/modes"),
  },
  { "slim-template/vim-slim", ft = "slim" },

  -- Sidebar / scroll
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/nvim-scrollbar"),
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = { "BufReadPost", "BufNewFile" },
    config = conf("rc/pluginconfig/nvim-ufo"),
  },

  -- Window / buffers
  {
    "famiu/bufdelete.nvim",
    event = "VeryLazy",
  },
  {
    "akinsho/bufferline.nvim",
    cmd = {
      "BufferLinePick",
      "BufferLineCyclePrev",
      "BufferLineCycleNext",
      "BufferLineMovePrev",
      "BufferLineMoveNext",
      "BufferLineGoToBuffer",
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = conf("rc/pluginconfig/bufferline"),
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = conf("rc/pluginconfig/lualine"),
  },
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = "NoNeckPain",
    config = conf("rc/pluginconfig/no-neck-pain"),
  },
}
