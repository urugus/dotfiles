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
    event = "VeryLazy",
    enabled = function()
      return not os.getenv("DISABLE_DEVICONS") or os.getenv("DISABLE_DEVICONS") == "false"
    end,
  },
  {
    "folke/snacks.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/snacks"),
  },
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      legacy_computing_symbols_support = false,
      smear_insert_mode = true,
      cursor_color = "#d3cdc3",
    },
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
    event = "BufReadPost",
    config = conf("rc/pluginconfig/vim-illuminate"),
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/todo-comments"),
  },
  {
    "mvllow/modes.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/modes"),
  },
  { "slim-template/vim-slim", ft = "slim" },

  -- Sidebar / scroll
  {
    "GustavoKatel/sidebar.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/sidebar"),
  },
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
    event = "BufReadPost",
    config = conf("rc/pluginconfig/nvim-ufo"),
  },

  -- Window / buffers
  {
    "famiu/bufdelete.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/bufdelete"),
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/bufferline"),
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/lualine"),
  },
  {
    "shortcuts/no-neck-pain.nvim",
    cmd = "NoNeckPain",
    config = conf("rc/pluginconfig/no-neck-pain"),
  },
}
