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

-- Setup lazy.nvim
require("lazy").setup({
  ------------------------------------------------------------
  -- I. Initial setting, Plugins manager
  {
    "folke/lazy.nvim",
    config = function()
      require("rc/pluginconfig/lazy")
    end,
  },
  {
    "williamboman/mason.nvim",
    event = { "VeryLazy" },
    build = ":MasonUpdate",
    config = function()
      require("rc/pluginconfig/mason")
    end,
  },
  { "folke/which-key.nvim", event = "VeryLazy" },

  ------------------------------------------------------------
  -- II. Snipped & IME
  { "vim-denops/denops.vim" },
  {
    "vim-skk/skkeleton",
    config = function()
      require("rc/pluginconfig/skkeleton")
    end,
  },
  {
    "delphinus/skkeleton_indicator.nvim",
    config = function()
      require("rc/pluginconfig/skkeleton_indicator")
    end,
  },

  ------------------------------------------------------------
  -- III. Appearance & UI
  -- A. Color scheme, Fonts, Animation
  {
    "Mofiqul/vscode.nvim",
    config = function()
      require("rc/pluginconfig/vscode")
    end,
  },
  {
    "kyazdani42/nvim-web-devicons",
    lazy = false,
    enabled = function()
      return not os.getenv("DISABLE_DEVICONS") or os.getenv("DISABLE_DEVICONS") == "false"
    end,
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    version = "*",
    config = function()
      require("rc/pluginconfig/mini-animate")
    end,
  },
  -- B. Layout
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/indent-blankline")
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/Comment")
    end,
  },
  {
    "xiyaowong/nvim-cursorword",
    config = function()
      require("rc/pluginconfig/nvim-cursorword")
    end,
  },
  {
    "RRethy/vim-illuminate",
    config = function()
      require("rc/pluginconfig/vim-illuminate")
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    config = function()
      require("rc/pluginconfig/todo-comments")
    end,
  },
  {
    "mvllow/modes.nvim",
    config = function()
      require("rc/pluginconfig/modes")
    end,
  },
  { "slim-template/vim-slim" },
  -- C. Sidebar, Scroll
  {
    "GustavoKatel/sidebar.nvim",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/sidebar")
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    lazy = true,
    config = function()
      require("rc/pluginconfig/nvim-scrollbar")
    end,
  },

  ------------------------------------------------------------
  -- IV. Window, Buffers
  {
    "famiu/bufdelete.nvim",
    config = function()
      require("rc/pluginconfig/bufdelete")
    end,
  },
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("rc/pluginconfig/bufferline")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("rc/pluginconfig/lualine")
    end,
  },
  {
    "shortcuts/no-neck-pain.nvim",
    config = function()
      require("rc/pluginconfig/no-neck-pain")
    end,
  },

  ------------------------------------------------------------
  -- V. Yank, Paste
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/yanky")
    end,
  },
  {
    "tversteeg/registers.nvim",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/registers")
    end,
  },

  ------------------------------------------------------------
  -- VI. Search, Filer
  {
    "haya14busa/vim-asterisk",
    config = function()
      vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-asterisk.vim")
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    event = { "VimEnter" },
    config = function()
      require("rc/pluginconfig/telescope")
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "Allianaab2m/telescope-kensaku.nvim",
        config = function()
          require("telescope").load_extension("kensaku") -- :Telescope kensaku
        end,
        dependencies = {
          { "lambdalisue/vim-kensaku", lazy = true },
        },
      },
    },
  },
  {
    "nvim-telescope/telescope-github.nvim",
    lazy = true,
    config = function()
      require("telescope").load_extension("gh")
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = true,
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "LinArcX/telescope-changes.nvim",
    lazy = true,
    config = function()
      require("telescope").load_extension("changes")
    end,
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    lazy = true,
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },
  {
    "nvim-telescope/telescope-smart-history.nvim",
    lazy = true,
    config = function()
      require("telescope").load_extension("smart_history")
    end,
    build = function()
      os.execute("mkdir -p " .. vim.fn.stdpath("state") .. "databases/")
    end,
  },
  { "nvim-telescope/telescope-symbols.nvim", lazy = true },
  {
    "debugloop/telescope-undo.nvim",
    lazy = true,
    config = function()
      require("telescope").load_extension("undo")
    end,
  },

  ------------------------------------------------------------
  -- VII. LSP & Completion / Snipped
  -- A. Completion
  {
    "hrsh7th/nvim-cmp",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/nvim-cmp")
    end,
  },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-nvim-lsp-document-symbol", lazy = true },
  { "hrsh7th/cmp-buffer", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },
  { "hrsh7th/cmp-nvim-lua", lazy = true },
  { "hrsh7th/cmp-emoji", lazy = true },
  { "hrsh7th/cmp-calc", lazy = true },
  { "rinx/cmp-skkeleton", lazy = true },
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
    config = function()
      require("rc/pluginconfig/lspkind-nvim")
    end,
  },
  -- B. LSP
  {
    "folke/neoconf.nvim",
    config = function()
      require("rc/pluginconfig/neoconf")
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/nvim-lspconfig")
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/mason-lspconfig")
    end,
  },
  {
    "weilbith/nvim-lsp-smag",
    event = "VeryLazy",
  },
  -- C. LSP's UI
  {
    "nvimdev/lspsaga.nvim",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/lspsaga")
    end,
  },
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/trouble")
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "BufEnter",
    config = function()
      require("rc/pluginconfig/fidget")
    end,
  },
  -- D. Snipped
  {
    "L3MON4D3/LuaSnip",
    event = "VimEnter",
    build = "make install_jsregexp",
    config = function()
      require("rc/pluginconfig/LuaSnip")
    end,
  },
  {
    "benfowler/telescope-luasnip.nvim",
    event = "VimEnter",
    config = function()
      require("telescope").load_extension("luasnip")
    end,
  },

  ------------------------------------------------------------
  -- VIII. Treesitter & Cordes analyzer
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "VeryLazy" },
    build = ":TSUpdateSync",
    config = function()
      require("rc/pluginconfig/nvim-treesitter")
    end,
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  { "nvim-treesitter/nvim-treesitter-refactor", lazy = true },
  { "nvim-treesitter/nvim-tree-docs", lazy = true },
  { "yioneko/nvim-yati", lazy = true },
  {
    "RRethy/nvim-treesitter-endwise",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require("rc/pluginconfig/nvim-treesitter-endwise")
    end,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "VeryLazy" },
  {
    "chrisgrieser/nvim-various-textobjs",
    lazy = true,
    config = function()
      require("rc/pluginconfig/nvim-various-textobjs")
    end,
  },
  {
    "mizlan/iswap.nvim",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/iswap")
    end,
  },
  {
    "mfussenegger/nvim-treehopper",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/nvim-treehopper")
    end,
  },
  {
    "David-Kunz/treesitter-unit",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/treesitter-unit")
    end,
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
    config = function()
      require("rc/pluginconfig/hlargs")
    end,
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
    config = function()
      require("rc/pluginconfig/neogen")
    end,
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
    config = function()
      require("rc/pluginconfig/peek")
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/img-clip")
    end,
  },
  -- D. Text object
  {
    "andymass/vim-matchup",
    event = "VeryLazy",
    config = function()
      vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-matchup.vim")
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/nvim-autopairs")
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/nvim-surround")
    end,
  },
  -- E. Lint & Formatter
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/nvim-lint")
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/conform")
    end,
  },
  { "tani/vim-typo" },
  -- F. Git & Version control
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/neogit")
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/diffview")
    end,
  },
  { "akinsho/git-conflict.nvim" },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("rc/pluginconfig/gitsigns")
    end,
  },
  {
    "dinhhuy258/git.nvim",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/git")
    end,
  },
  -- G. Notification
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/nvim-notify")
    end,
  },
  -- H. Lua libraries
  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "MunifTanjim/nui.nvim" },
  -- I. Standard enhancement
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("rc/pluginconfig/toggleterm")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VimEnter",
    branch = "main",
    config = function()
      require("rc/pluginconfig/neo-tree")
    end,
  },
  -- J. Github
  {
    "pwntester/octo.nvim",
    event = "VeryLazy",
    config = function()
      require("octo").setup()
    end,
  },
  -- K. AI Support
  { "github/copilot.vim" },
  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    config = function()
      vim.defer_fn(function()
        require("rc/pluginconfig/copilot")
      end, 100)
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    branch = "main",
    config = function()
      require("rc/pluginconfig/CopilotChat")
    end,
    opts = {
      debug = true,
    },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    build = "make",
    config = function()
      require("rc/pluginconfig/avante")
    end,
  },
  -- L. Browser support
  {
    "subnut/nvim-ghost.nvim",
    event = "VeryLazy",
    config = function()
      require("rc/pluginconfig/nvim-ghost")
    end,
  },
  -- M. Startup menu
  {
    "goolord/alpha-nvim",
    config = function()
      require("rc/pluginconfig/alpha-nvim")
    end,
  },
  -- N. Test
  {
    "klen/nvim-test",
    lazy = true,
    config = function()
      require("rc/pluginconfig/nvim-test")
    end,
  },
  -- O. Analyzer
  { "wakatime/vim-wakatime" },

  ------------------------------------------------------------
  -- 自動プラグイン更新チェック
  checker = { enabled = true },
})
