local shared = require("rc.plugins.shared")
local conf = shared.conf

return {
  -- Base
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    build = ":MasonUpdate",
    config = conf("rc/pluginconfig/mason"),
  },
  { "folke/which-key.nvim", event = "VeryLazy" },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "VimEnter",
    config = conf("rc/pluginconfig/nvim-cmp"),
  },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-nvim-lsp-document-symbol", lazy = true },
  { "hrsh7th/cmp-buffer", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },
  { "hrsh7th/cmp-nvim-lua", lazy = true },
  { "hrsh7th/cmp-emoji", lazy = true },
  { "hrsh7th/cmp-calc", lazy = true },
  -- { "rinx/cmp-skkeleton", lazy = true },
  { "f3fora/cmp-spell", lazy = true },
  { "saadparwaiz1/cmp_luasnip", lazy = true },
  {
    "tzachar/cmp-tabnine",
    lazy = true,
    build = "./install.sh",
  },
  { "ray-x/cmp-treesitter", lazy = true },
  { "lukas-reineke/cmp-rg", lazy = true },
  { "lukas-reineke/cmp-under-comparator", lazy = true },
  {
    "onsails/lspkind-nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/lspkind-nvim"),
  },

  -- LSP core
  {
    "folke/neoconf.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/neoconf"),
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VimEnter",
    config = conf("rc/lsp"),
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    event = "VimEnter",
    config = false,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/tiny-inline-diagnostic"),
  },
  {
    "weilbith/nvim-lsp-smag",
    event = "VeryLazy",
  },

  -- LSP UI
  {
    "nvimdev/lspsaga.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/lspsaga"),
  },
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/trouble"),
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "BufEnter",
    config = conf("rc/pluginconfig/fidget"),
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    event = "VimEnter",
    build = "make install_jsregexp",
    config = conf("rc/pluginconfig/LuaSnip"),
  },

  -- Lint & format
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/nvim-lint"),
  },
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/conform"),
  },
}
