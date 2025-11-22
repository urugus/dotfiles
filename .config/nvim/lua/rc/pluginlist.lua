local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

local util = require("rc.util")
local conf = util.safe_config
local source = util.safe_source

-- Setup lazy.nvim
require("lazy").setup({
  ------------------------------------------------------------
  -- I. Initial setting, Plugins manager
  {
    "folke/lazy.nvim",
    config = conf("rc/pluginconfig/lazy"),
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    build = ":MasonUpdate",
    config = conf("rc/pluginconfig/mason"),
  },
  { "folke/which-key.nvim", event = "VeryLazy" },

  ------------------------------------------------------------
  -- II. Snipped & IME
  -- { "vim-denops/denops.vim" },
  -- {
  --   "vim-skk/skkeleton",
  --   config = function()
  --     require("rc/pluginconfig/skkeleton")
  --   end,
  -- },
  -- {
  --   "urugus/skkeleton-snacks",
  --   dependencies = {
  --     "vim-skk/skkeleton",
  --     "folke/snacks.nvim",
  --   },
  --   event = "VeryLazy", -- 遅延読み込み
  --   config = true,
  -- },
  -- {
  --   "delphinus/skkeleton_indicator.nvim",
  --   config = function()
  --     require("rc/pluginconfig/skkeleton_indicator")
  --   end,
  -- },

  ------------------------------------------------------------
  -- III. Appearance & UI
  -- A. Color scheme, Fonts, Animation
  {
    "Mofiqul/vscode.nvim",
    config = conf("rc/pluginconfig/vscode"),
  },
  {
    "kyazdani42/nvim-web-devicons",
    lazy = false,
    enabled = function()
      return not os.getenv("DISABLE_DEVICONS") or os.getenv("DISABLE_DEVICONS") == "false"
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
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
  -- "folke/snacks.nvim" animate

  -- B. Layout
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/indent-blankline"),
  },
  -- "folke/snacks.nvim" indent
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/Comment"),
  },
  {
    "xiyaowong/nvim-cursorword",
    config = conf("rc/pluginconfig/nvim-cursorword"),
  },
  {
    "RRethy/vim-illuminate",
    config = conf("rc/pluginconfig/vim-illuminate"),
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    config = conf("rc/pluginconfig/todo-comments"),
  },
  {
    "mvllow/modes.nvim",
    config = conf("rc/pluginconfig/modes"),
  },
  { "slim-template/vim-slim" },
  -- C. Sidebar, Scroll
  -- "folke/snacks.nvim" scroll
  {
    "GustavoKatel/sidebar.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/sidebar"),
  },
  {
    "petertriho/nvim-scrollbar",
    lazy = true,
    config = conf("rc/pluginconfig/nvim-scrollbar"),
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = conf("rc/pluginconfig/nvim-ufo"),
  },

  ------------------------------------------------------------
  -- IV. Window, Buffers
  {
    "famiu/bufdelete.nvim",
    config = conf("rc/pluginconfig/bufdelete"),
  },
  {
    "akinsho/bufferline.nvim",
    config = conf("rc/pluginconfig/bufferline"),
  },
  {
    "nvim-lualine/lualine.nvim",
    config = conf("rc/pluginconfig/lualine"),
  },
  {
    "shortcuts/no-neck-pain.nvim",
    config = conf("rc/pluginconfig/no-neck-pain"),
  },

  ------------------------------------------------------------
  -- V. Yank, Paste
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

  ------------------------------------------------------------
  -- VI. Search, Filer
  {
    "haya14busa/vim-asterisk",
    config = source("~/.config/nvim/rc/pluginconfig/vim-asterisk.vim"),
  },
  -- "folke/snacks.nvim" picker

  ------------------------------------------------------------
  -- VII. LSP & Completion / Snipped
  -- A. Completion
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
  -- B. LSP
  {
    "folke/neoconf.nvim",
    config = conf("rc/pluginconfig/neoconf"),
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VimEnter",
    config = conf("rc/pluginconfig/mason-lspconfig"),
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    event = "VimEnter",
    config = conf("rc/pluginconfig/nvim-lspconfig"),
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
  -- C. LSP's UI
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
  -- D. Snipped
  {
    "L3MON4D3/LuaSnip",
    event = "VimEnter",
    build = "make install_jsregexp",
    config = conf("rc/pluginconfig/LuaSnip"),
  },
  -- {
  --   "benfowler/telescope-luasnip.nvim",
  --   event = "VimEnter",
  --   config = function()
  --     require("telescope").load_extension("luasnip")
  --   end,
  -- },

  ------------------------------------------------------------
  -- VIII. Treesitter & Cordes analyzer
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
      if vim.fn.expand("%:p") ~= "" then
        vim.cmd.edit({ bang = true })
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
    config = true,
  },

  ------------------------------------------------------------
  -- IX. Others
  -- A. Data display, Utilities
  {
    "hat0uma/csvview.nvim",
    config = function()
      require("csvview").setup()
    end,
  },
  -- B. Annotation
  {
    "danymat/neogen",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/neogen"),
  },
  -- C. Programing support
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
  -- D. Text object
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
  -- E. Lint & Formatter
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
  -- F. Git & Version control
  -- "folke/snacks.nvim" lazygit
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
  { "akinsho/git-conflict.nvim" },
  {
    "lewis6991/gitsigns.nvim",
    config = conf("rc/pluginconfig/gitsigns"),
  },
  {
    "dinhhuy258/git.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/git"),
  },
  -- G. Notification
  -- "folke/snacks.nvim" notifier

  -- H. Lua libraries
  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "MunifTanjim/nui.nvim" },
  -- I. Standard enhancement
  {
    "akinsho/toggleterm.nvim",
    config = conf("rc/pluginconfig/toggleterm"),
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VimEnter",
    branch = "main",
    config = conf("rc/pluginconfig/neo-tree"),
  },
  -- J. Github
  {
    "pwntester/octo.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = conf("rc/pluginconfig/octo"),
  },
  -- K. AI Support
  { "github/copilot.vim" },
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
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = conf("rc/pluginconfig/claude-code"),
  },
  {
    "johnseth97/codex.nvim",
    lazy = true,
    cmd = { "Codex" },
    config = conf("rc/pluginconfig/codex"),
  },
  -- L. Browser support
  {
    "subnut/nvim-ghost.nvim",
    event = "VeryLazy",
    config = conf("rc/pluginconfig/nvim-ghost"),
  },
  -- M. Startup menu
  -- "folke/snacks.nvim" dashboard

  -- N. Test
  {
    "klen/nvim-test",
    lazy = true,
    config = conf("rc/pluginconfig/nvim-test"),
  },
  -- O. Analyzer
  { "wakatime/vim-wakatime" },

  -- P. GUI
  {
    "3rd/image.nvim",
    lazy = true,
  },

  -- Q. External services
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

  ------------------------------------------------------------
  -- 自動プラグイン更新チェック
  checker = { enabled = true },
})
