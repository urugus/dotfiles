local shared = require("rc.plugins.shared")
local conf = shared.conf
local source = shared.source

return {
  -- Data display / utilities
  {
    "hat0uma/csvview.nvim",
    ft = { "csv" },
    config = function()
      require("csvview").setup()
    end,
  },
  {
    "danymat/neogen",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/neogen"),
  },
  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    event = "VeryLazy",
    ft = { "markdown" },
    enabled = function()
      return vim.fn.executable("deno")
    end,
    config = conf("rc/pluginconfig/peek"),
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown" },
    },
    ft = { "markdown" },
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/img-clip"),
  },

  -- Git / VCS
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/neogit"),
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/diffview"),
  },
  { "akinsho/git-conflict.nvim", event = "BufReadPre" },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = conf("rc/pluginconfig/gitsigns"),
  },
  {
    "dinhhuy258/git.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/git"),
  },

  -- Lua libraries
  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "MunifTanjim/nui.nvim" },

  -- Terminal / file explorer
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/toggleterm"),
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VimEnter",
    branch = "main",
    config = conf("rc/pluginconfig/neo-tree"),
  },

  -- GitHub / collaboration
  {
    "pwntester/octo.nvim",
    dependencies = { "folke/snacks.nvim" },
    cmd = "Octo",
    config = conf("rc/pluginconfig/octo"),
  },

  -- AI support
  {
    "github/copilot.vim",
    event = "InsertEnter",
  },
  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    config = function()
      vim.defer_fn(conf("rc/pluginconfig/copilot"), 100)
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    branch = "main",
    config = conf("rc/pluginconfig/CopilotChat"),
    opts = {
      debug = true,
    },
  },
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    config = conf("rc/pluginconfig/claude-code"),
  },
  {
    "johnseth97/codex.nvim",
    lazy = true,
    cmd = { "Codex" },
    config = conf("rc/pluginconfig/codex"),
  },

  -- Browser support
  {
    "subnut/nvim-ghost.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/nvim-ghost"),
  },

  -- Test
  {
    "klen/nvim-test",
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    config = conf("rc/pluginconfig/nvim-test"),
  },

  -- Analyzer
  { "wakatime/vim-wakatime", event = "VeryLazy" },

  -- GUI / media
  {
    "3rd/image.nvim",
    ft = { "markdown", "norg", "org", "text" },
  },

  -- External services
  {
    "urugus/neo-slack.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "junegunn/vim-emoji",
      "folke/snacks.nvim",
    },
    event = "VeryLazy",
    config = conf("rc/pluginconfig/neo-slack"),
  },
}
