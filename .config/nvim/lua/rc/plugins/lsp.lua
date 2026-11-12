local conf = require("rc.plugins.shared").conf

return {
  -- Base
  {
    "mason-org/mason.nvim",
    event = "VeryLazy",
    build = ":MasonUpdate",
    config = conf("rc/pluginconfig/mason"),
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/which-key"),
  },

  -- Completion (markdown のみ)
  {
    "hrsh7th/nvim-cmp",
    ft = "markdown",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "rinx/cmp-skkeleton",
    },
    config = conf("rc/pluginconfig/nvim-cmp"),
  },

  -- SKK (Japanese input)
  {
    "vim-denops/denops.vim",
    lazy = false,
  },
  {
    "vim-skk/skkeleton",
    dependencies = {
      "vim-denops/denops.vim",
      "urugus/skkeleton-snacks",
      "delphinus/skkeleton_indicator.nvim",
    },
    event = { "InsertEnter", "CmdlineEnter", "TermEnter" },
    config = conf("rc/pluginconfig/skkeleton"),
  },
  { "urugus/skkeleton-snacks", lazy = true },
  {
    "delphinus/skkeleton_indicator.nvim",
    lazy = true,
    opts = { fadeOutMs = 600 },
  },

  -- LSP core
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = conf("rc/lsp"),
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    config = false,
  },

  -- LSP UI
  {
    "nvimdev/lspsaga.nvim",
    cmd = "Lspsaga",
    config = conf("rc/pluginconfig/lspsaga"),
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    config = conf("rc/pluginconfig/fidget"),
  },
}
