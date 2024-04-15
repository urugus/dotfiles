local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command("silent !git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end
if vim.fn.executable("python3") == 1 then
  vim.cmd(
    [[let g:python_version = substitute(system("python3 -c 'from sys import version_info as v; print(v[0] * 100 + v[1])'"), '\n', '', 'g')]]
  )
end

vim.cmd([[packadd packer.nvim]])
require("rc/packer")

return require("packer").startup(function(use)
  -- ------------------------------------------------------------
  -- Installer

  -- Plugin Manager
  use({ "wbthomason/packer.nvim", opt = true })

  -- External package Installer
  use({
    "williamboman/mason.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/mason")
    end,
  })

  -- ------------------------------------------------------------
  -- Library

  --------------------------------
  -- Vim script Library
  use({ "tpope/vim-repeat" })

  -- Lua Library
  use({ "nvim-lua/popup.nvim", mocule = "popup" })
  use({ "nvim-lua/plenary.nvim" })
  -- use({ "tami5/sqlite.lua", module = "sqlite" })
  use({ "MunifTanjim/nui.nvim", module = "nui" })

  --------------------------------
  -- Notify
  use({ "rcarriga/nvim-notify", module = "notify"})

  --------------------------------
  -- ColorScheme
  local colorscheme = "vscode.nvim"
  use({
    "Mofiqul/vscode.nvim",
    event = { "VimEnter" },
    config = function()
      require("rc/pluginconfig/vscode")
    end,
  })

  --------------------------------
  -- Font
  if not os.getenv("DISABLE_DEVICONS") or os.getenv("DISABLE_DEVICONS") == "false" then
    -- use {'ryanoasis/vim-devicons'}
    use({ "kyazdani42/nvim-web-devicons", after = colorscheme })
  end

  --------------------------------------------------------------
  -- LSP & completion

  --------------------------------
  -- Auto Completion
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "L3MON4D3/LuaSnip", opt = true, event = "VimEnter" },
      { "windwp/nvim-autopairs", opt = true, event = "VimEnter" },
    },
    after = { "LuaSnip", "nvim-autopairs" },
    config = function()
      require("rc/pluginconfig/nvim-cmp")
    end,
  })
  use({
    "onsails/lspkind-nvim",
    module = "lspkind",
    config = function()
      require("rc/pluginconfig/lspkind-nvim")
    end,
  })
  use({ "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lsp" })
  use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-calc", after = "nvim-cmp" })
  use({ "f3fora/cmp-spell", after = "nvim-cmp" })
  use({ "yutkat/cmp-mocword", after = "nvim-cmp" })
  use { 'rinx/cmp-skkeleton', after = { 'nvim-cmp', 'skkeleton' } }
  use({
    "uga-rosa/cmp-dictionary",
    after = "nvim-cmp",
    config = function()
      require("rc/pluginconfig/cmp-dictionary")
    end,
  })
  use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
  use({
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    after = "nvim-cmp",
  })
  use({ "ray-x/cmp-treesitter", after = "nvim-cmp" })
  use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
  use({ "lukas-reineke/cmp-rg", after = "nvim-cmp" })
  use({ "lukas-reineke/cmp-under-comparator", module = "cmp-under-comparator" })

  --------------------------------
  -- Language Server Protocol(LSP)
  use({
    "williamboman/mason-lspconfig.nvim",
    after = { "mason.nvim" },
    config = function()
      require("rc/pluginconfig/mason-lspconfig")
    end,
  })
  use({
    "neovim/nvim-lspconfig",
    -- event = { "BufReadPre" },
    config = function()
      require("rc/pluginconfig/nvim-lspconfig")
    end,
  })
  use({ "weilbith/nvim-lsp-smag", after = "nvim-lspconfig" })


  --------------------------------
  -- LSP's UI
  use({
    "tami5/lspsaga.nvim",
    after = "mason.nvim",
    config = function()
      require("rc/pluginconfig/lspsaga")
    end,
  })
  use({
    "folke/lsp-colors.nvim",
    module = "lsp-colors"
  })
  use({
    "folke/trouble.nvim",
    after = { "mason.nvim" },
    config = function()
      require("rc/pluginconfig/trouble")
    end,
  })
  use({
    "j-hui/fidget.nvim",
    after = "mason.nvim",
    config = function()
      require("rc/pluginconfig/fidget")
    end,
  })

  --------------------------------
  -- AI completion
  use({ "github/copilot.vim" })
  use({
    "zbirenbaum/copilot.lua",
    after = { "copilot.vim" },
    config = function()
      vim.schedule(function()
        require("copilot").setup()
      end, 100)
    end,
  })

  -------------------------------
  -- Auto fixing typo
  use({ "tani/vim-typo" })

  --------------------------------------------------------------
  -- FuzzyFinders

  --------------------------------
  -- telescope.nvim
  use({
    "nvim-telescope/telescope.nvim",
    -- requires = { { "nvim-lua/plenary.nvim", opt = true }, { "nvim-lua/popup.nvim", opt = true } },
    after = { colorscheme },
    config = function()
      require("rc/pluginconfig/telescope")
    end,
  })
  -- use({
  --   "nvim-telescope/telescope-frecency.nvim",
  --   after = { "telescope.nvim" },
  --   config = function()
  --     require("telescope").load_extension("frecency")
  --   end,
  -- })
  use({
    "nvim-telescope/telescope-github.nvim",
    after = { "telescope.nvim" },
    config = function()
      require("telescope").load_extension("gh")
    end,
  })
  use({ "nvim-telescope/telescope-symbols.nvim", after = { "telescope.nvim" } })
  use({
    "nvim-telescope/telescope-packer.nvim",
    after = { "telescope.nvim" },
    config = function()
      require("telescope").load_extension("packer")
    end,
  })
  -- use({
  --   "nvim-telescope/telescope-smart-history.nvim",
  --   requires = { { "nvim-telescope/telescope.nvim", opt = true }, { "tami5/sqlite.lua", opt = true } },
  --   after = { "telescope.nvim", "sqlite.lua" },
  --   config = function()
  --     require("telescope").load_extension("smart_history")
  --   end,
  --   run = function()
  --     os.execute("mkdir -p ~/.local/share/nvim/databases/")
  --   end,
  -- })

  --------------------------------
  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    after = { colorscheme },
    run = ":TSUpdate",
    config = function()
      require("rc/pluginconfig/nvim-treesitter")
    end,
  })
  use({ "JoosepAlviste/nvim-ts-context-commentstring", after = { "nvim-treesitter" } })
  use({ "nvim-treesitter/nvim-treesitter-refactor", after = { "nvim-treesitter" } })
  use({ "nvim-treesitter/nvim-tree-docs", after = { "nvim-treesitter" } })
  use({ "vigoux/architext.nvim", after = { "nvim-treesitter" } })
  use({ "yioneko/nvim-yati", after = "nvim-treesitter" })
  use({ "RRethy/nvim-treesitter-endwise",
    after = { "nvim-treesitter" },
    config = function()
      require("rc/pluginconfig/nvim-treesitter-endwise")
    end,
  })
  use({ "windwp/nvim-ts-autotag", after = { "nvim-treesitter" } })
  use({
    "nvim-treesitter/nvim-treesitter-context",
    after = { "nvim-treesitter" },
    config = function()
      require("rc/pluginconfig/treesitter-context")
    end,
  })

  --------------------------------
  -- Treesitter textobject & operator
  use({ "nvim-treesitter/nvim-treesitter-textobjects", after = { "nvim-treesitter" } })
  -- incremental-selection
  use({
    "mizlan/iswap.nvim",
    after = { "nvim-treesitter" },
    config = function()
      require("rc/pluginconfig/iswap")
    end,
  })
  use({
    "David-Kunz/treesitter-unit",
    after = { "nvim-treesitter" },
    config = function()
      require("rc/pluginconfig/treesitter-unit")
    end,
  })

  --------------------------------
  -- Treesitter UI customize
  use({ "p00f/nvim-ts-rainbow", after = { "nvim-treesitter" } })
  use({ "haringsrob/nvim_context_vt", after = { "nvim-treesitter", colorscheme } })
  use({
    "m-demare/hlargs.nvim",
    after = { "nvim-treesitter" },
    config = function()
      require("rc/pluginconfig/hlargs")
    end,
  })

  --------------------------------------------------------------
  -- Appearance

  --------------------------------
  -- Statusline
  use({
    "nvim-lualine/lualine.nvim",
    after = colorscheme,
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("rc/pluginconfig/lualine")
    end,
  })
  use({
    "SmiteshP/nvim-navic",
    module = "nvim-navic",
    setup = function()
      require("rc/pluginconfig/nvim-navic")
    end,
  })

  --------------------------------
  -- Bufferline
  if not vim.g.vscode then
    use({
      "akinsho/bufferline.nvim",
      after = colorscheme,
      config = function()
        require("rc/pluginconfig/bufferline")
      end,
    })
  end

  ----------------------------------
  ---- Syntax

  --------------------------------
  -- Highlight
  -- There are Lua plugin. I haven't tried it yet because I'm satisfied with coc.
  -- norcalli/nvim-colorizer.lua
  use({
    "xiyaowong/nvim-cursorword",
    after = colorscheme,
    config = function()
      require("rc/pluginconfig/nvim-cursorword")
    end,
  })
  use({
    "RRethy/vim-illuminate",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/vim-illuminate")
    end,
  })
  use({
    "norcalli/nvim-colorizer.lua",
    event = "VimEnter",
    config = function()
      require("colorizer").setup()
    end,
  })
  use({
    "Pocco81/HighStr.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/HighStr")
    end,
  })
  use({
    "folke/todo-comments.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/todo-comments")
    end,
  })
  use({
    "mvllow/modes.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/modes")
    end,
  })
  use({ "slim-template/vim-slim" })

  --------------------------------
  -- Layout
  use({
    "myusuf3/numbers.vim",
    cmd = { "NumbersToggle", "NumbersOnOff" },
    config = function()
      vim.cmd("source ~/.config/nvim/rc/pluginconfig/numbers.vim")
    end,
  })

  --------------------------------
  -- Sidebar
  -- conflict with clever-f (augroup sidebar_nvim_prevent_buffer_override)
  use({
    "GustavoKatel/sidebar.nvim",
    cmd = { "SidebarNvimToggle" },
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/sidebar")
    end,
  })

  --------------------------------
  -- Menu
  -- use {'kizza/actionmenu.nvim', event = "VimEnter"}
  use({
    "sunjon/stylish.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/stylish")
    end,
  })

  --------------------------------
  -- Startup screen
  use({
    "goolord/alpha-nvim",
    config = function()
      require("rc/pluginconfig/alpha-nvim")
    end,
  })
  -- startup-nvim/startup.nvim

  --------------------------------
  -- Scrollbar
  use({
    "petertriho/nvim-scrollbar",
    requires = { { "kevinhwang91/nvim-hlslens", opt = true } },
    after = { colorscheme, "nvim-hlslens" },
    config = function()
      require("rc/pluginconfig/nvim-scrollbar")
    end,
  })

  --------------------------------
  -- Cursor
  use({
    "edluffy/specs.nvim",
    cmd = { "SpecsEnable" },
    config = function()
      require("rc/pluginconfig/specs")
    end,
  })

  -- ------------------------------------------------------------
  -- Editing

  --------------------------------
  -- runtime
  use({'vim-denops/denops.vim'})


  --------------------------------
  -- IM
  use({
    "vim-skk/skkeleton",
    after = { "denops.vim" },
    config = function()
      require("rc/pluginconfig/skkeleton")
    end,
  })

  --------------------------------
  -- Move
  use({
    "phaazon/hop.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/hop")
    end,
  })
  ----------------
  -- Horizontal Move
  -- use {'gukz/ftFt.nvim', event = "VimEnter", config = function() require 'rc/pluginconfig/ftFt' end}
  -- still wasn't great.
  use({
    "ggandor/lightspeed.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/lightspeed")
    end,
  })

  -- Operator
  use({
    "machakann/vim-sandwich",
    config = function()
      vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-sandwich.vim")
    end,
  })

  --------------------------------
  -- Yank
  use({
    "gbprod/yanky.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/yanky")
    end,
  })
  -- use({
  --   "AckslD/nvim-neoclip.lua",
  --   requires = { { "nvim-telescope/telescope.nvim", opt = true }, { "tami5/sqlite.lua", opt = true } },
  --   after = { "telescope.nvim", "sqlite.lua" },
  --   config = function()
  --     require("rc/pluginconfig/nvim-neoclip")
  --   end,
  -- })

  --------------------------------
  -- Paste
  -- use({ "yutkat/auto-paste-mode.vim", event = "VimEnter" })
  if vim.fn.has("clipboard") == 1 then
    use({
      "tversteeg/registers.nvim",
      event = "VimEnter",
      config = function()
        require("rc/pluginconfig/registers")
      end,
    })
  end

  --------------------------------------------------------------
  -- Search

  --------------------------------
  -- Find
  use({
    "kevinhwang91/nvim-hlslens",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/nvim-hlslens")
    end,
  })
  use({
    "haya14busa/vim-asterisk",
    event = "VimEnter",
    config = function()
      vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-asterisk.vim")
    end,
  })

  --------------------------------------------------------------
  -- File switcher

  --------------------------------
  -- Buffer
  use({
    "famiu/bufdelete.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/bufdelete")
    end,
  })

  --------------------------------
  -- Filer
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "main",
    requires = {
      "MunifTanjim/nui.nvim",
    },
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/neo-tree")
    end,
  })

  ------------------------------------------------------------
  -- Coding

  --------------------------------
  -- Reading assistant
  use({
    "lukas-reineke/indent-blankline.nvim",
    -- after = { colorscheme },
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/indent-blankline")
    end,
  })

  --------------------------------
  -- Comment out
  use({
    "numToStr/Comment.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/Comment")
    end,
  })

  --------------------------------
  -- Annotation
  use({
    "danymat/neogen",
    config = function()
      require("rc/pluginconfig/neogen")
    end,
    after = { "nvim-treesitter" },
  })

  --------------------------------
  -- Brackets
  use({
    "andymass/vim-matchup",
    after = { "nvim-treesitter" },
    config = function()
      vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-matchup.vim")
    end,
  })
  -- do not work correnctly
  use({
    "windwp/nvim-autopairs",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/nvim-autopairs")
    end,
  })

  --------------------------------
  -- Test
  use({
    "klen/nvim-test",
    after = { "nvim-treesitter" },
    config = function()
      require("rc/pluginconfig/nvim-test")
    end,
  })
  -- if vim.fn.executable("cargo") == 1 then
  --  use({ "michaelb/sniprun", run = "bash install.sh", cmd = { "SnipRun" } })
  -- end

  --------------------------------
  -- Lint
  use({
    "jose-elias-alvarez/null-ls.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/null-ls")
    end,
  })
  use({
    "dense-analysis/ale",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/ale")
    end,
  })

  --------------------------------
  -- Git
  use({
    "NeogitOrg/neogit",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/neogit")
    end,
  })
  use({
    "sindrets/diffview.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/diffview")
    end,
  })
  use({
    "akinsho/git-conflict.nvim",
    event = "VimEnter",
    config = function()
      require("git-conflict").setup()
    end,
  })
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/gitsigns")
    end,
  })
  use({
    "dinhhuy258/git.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/git")
    end
  })

  ------------------------------------------------------------
  -- Standard Feature Enhancement

  --------------------------------
  -- SpellCorrect (iabbr)
  use({
    "Pocco81/AbbrevMan.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/AbbrevMan")
    end,
  })

  --------------------------------
  -- Terminal
  use({
    "akinsho/toggleterm.nvim",
    after = { colorscheme },
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/toggleterm")
    end,
  })

  --------------------------------
  -- Programming Languages

  --------------------------------
  -- Markdown
  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })

  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  })

  ------------------------------------------------------------
  -- Standard Feature Enhancement
  use({ "lambdalisue/readablefold.vim" })

  --------------------------------------------------------------
  -- New features
  --------------------------------
  -- Manual
  use({
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/which-key")
    end,
  })

  --------------------------------
  -- Memo
  use({
    "renerocksai/telekasten.nvim",
    after = { "telescope.nvim" },
    require = { "renerocksai/calendar-vim" },
    config = function()
      require("rc/pluginconfig/telekasten")
    end,
  })

  --------------------------------
  -- Use editor in the browser
  use({
    "subnut/nvim-ghost.nvim",
    event = "VimEnter",
    config = function()
      require("rc/pluginconfig/nvim-ghost")
    end
  })

  --------------------------------
  -- Analytics
  if not os.getenv("DISABLE_WAKATIME") or os.getenv("DISABLE_WAKATIME") == "true" then
    if vim.fn.filereadable(vim.fn.expand("~/.wakatime.cfg")) == 1 then
      use({ "wakatime/vim-wakatime", event = "VimEnter" })
    end
  end

  --------------------------------
  -- Funny
  use({
    "eandrju/cellular-automaton.nvim",
    after = {"nvim-treesitter"}
  })
end)
