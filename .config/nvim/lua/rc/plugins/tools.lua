local shared = require("rc.plugins.shared")
local conf = shared.conf

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
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "RenderMarkdown" },
    opts = {
      file_types = { "markdown" },
      completions = {
        lsp = { enabled = true },
      },
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
  },
  { "akinsho/git-conflict.nvim", event = "BufReadPre" },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/gitsigns"),
  },

  -- Lua libraries (lazy loaded, pulled in by dependents)
  { "nvim-lua/plenary.nvim", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },

  -- Terminal / file explorer
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    config = conf("rc/pluginconfig/toggleterm"),
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    branch = "main",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = conf("rc/pluginconfig/neo-tree"),
  },

  -- GitHub / collaboration
  {
    "pwntester/octo.nvim",
    dependencies = { "folke/snacks.nvim" },
    cmd = "Octo",
    config = conf("rc/pluginconfig/octo"),
  },

  -- GUI / media
  {
    "3rd/image.nvim",
    build = false,
    ft = { "markdown", "norg", "org", "text" },
    opts = {
      processor = "magick_cli",
      -- 信頼できない Markdown を開いただけで外部 URL へ取りに行かないようにする
      integrations = {
        markdown = { download_remote_images = false },
        neorg = { download_remote_images = false },
      },
    },
  },
  {
    "brianhuster/live-preview.nvim",
    cmd = "LivePreview",
    dependencies = { "folke/snacks.nvim" },
  },
}
