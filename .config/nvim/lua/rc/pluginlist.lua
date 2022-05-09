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
	use({ "wbthomason/packer.nvim", opt = true })

	-- ------------------------------------------------------------
	-- Library

	--------------------------------
	-- Vim script Library
	use({ "tpope/vim-repeat" })

	-- Lua Library
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "tami5/sqlite.lua", module = "sqlite" })
	use({ "MunifTanjim/nui.nvim" })

	--------------------------------
	-- Font
	if not os.getenv("DISABLE_DEVICONS") or os.getenv("DISABLE_DEVICONS") == "false" then
		-- use {'ryanoasis/vim-devicons'}
		use({ "kyazdani42/nvim-web-devicons" })
	end

	--------------------------------
	-- Notify
	use({ "rcarriga/nvim-notify", event = "VimEnter" })

	--------------------------------
	-- ColorScheme
	local colorscheme = "vscode.nvim"
	use({
		"Mofiqul/vscode.nvim",
		config = function()
			require("rc/pluginconfig/vscode")
		end,
	})

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
		after = { "lspkind-nvim", "LuaSnip", "nvim-autopairs" },
		config = function()
			require("rc/pluginconfig/nvim-cmp")
		end,
	})
	use({
		"onsails/lspkind-nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/lspkind-nvim")
		end,
	})
	use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-omni", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
	use({ "zbirenbaum/copilot-cmp", after = { "nvim-cmp", "copilot.lua" } })
	-- use({ "hrsh7th/cmp-copilot", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-calc", after = "nvim-cmp" })
	use({ "f3fora/cmp-spell", after = "nvim-cmp" })
	use({ "yutkat/cmp-mocword", after = "nvim-cmp" })
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

	--------------------------------
	-- Language Server Protocol(LSP)
	use({
		"neovim/nvim-lspconfig",
		after = "cmp-nvim-lsp",
		config = function()
			require("rc/pluginconfig/nvim-lspconfig")
		end,
	})
	use({
		"williamboman/nvim-lsp-installer",
		requires = { { "RRethy/vim-illuminate", opt = true } },
		after = { "nvim-lspconfig", "vim-illuminate", "nlsp-settings.nvim" },
		config = function()
			require("rc/pluginconfig/nvim-lsp-installer")
		end,
	})
	-- -> hrsh7th/cmp-nvim-lsp-signature-help, hrsh7th/cmp-nvim-lsp-document-symbol
	-- use({
	-- 	"ray-x/lsp_signature.nvim",
	-- 	after = "nvim-lspconfig",
	-- 	config = function()
	-- 		require("rc/pluginconfig/lsp_signature")
	-- 	end,
	-- })
	use({
		"tamago324/nlsp-settings.nvim",
		after = { "nvim-lspconfig" },
		config = function()
			require("rc/pluginconfig/nlsp-settings")
		end,
	})
	use({ "weilbith/nvim-lsp-smag", after = "nvim-lspconfig" })
	-- library for litee
	-- use {
	--   'ldelossa/litee.nvim',
	--   after = 'nvim-lspconfig',
	--   config = function() require('litee.lib').setup({}) end
	-- }

	--------------------------------
	-- Linter
	use({
		"dense-analysis/ale",
		config = function()
			require("rc/pluginconfig/ale")
		end,
	})
	-- use({
	-- 	"nathunsmitty/nvim-ale-diagnostic",
	-- 	requires = "dense-analysis/ale",
	-- 	module = "nvim-ale-diagnostic"
	-- })



	--------------------------------
	-- LSP's UI
	-- use {'nvim-lua/lsp-status.nvim', after = 'nvim-lspconfig'}
	-- use {
	--   'nvim-lua/lsp_extensions.nvim',
	--   after = 'nvim-lsp-installer',
	--   config = function() require 'rc/pluginconfig/lsp_extensions' end
	-- }
	use({
		"tami5/lspsaga.nvim",
		after = "nvim-lsp-installer",
		config = function()
			require("rc/pluginconfig/lspsaga")
		end,
	})
	use({
		"folke/lsp-colors.nvim",
		event = "VimEnter",
	})
	use({
		"folke/trouble.nvim",
		after = { "nvim-lsp-installer", "lsp-colors.nvim" },
		config = function()
			require("rc/pluginconfig/trouble")
		end,
	})
	use({
		"j-hui/fidget.nvim",
		after = "nvim-lsp-installer",
		config = function()
			require("rc/pluginconfig/fidget")
		end,
	})
	-- use {
	--   'ray-x/navigator.lua',
	--   after = 'nvim-lsp-installer',
	--   requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make', opt = true},
	--   config = function() require 'rc/pluginconfig/navigator' end
	-- }
	-- use {
	--   'onsails/diaglist.nvim',
	--   after = 'nvim-lspconfig',
	--   config = function() require 'rc/pluginconfig/diaglist' end
	-- }
	-- -> lspsaa
	-- use {
	--   'rmagatti/goto-preview',
	--   after = 'nvim-lspconfig',
	--   config = function() require 'rc/pluginconfig/goto-preview' end
	-- }
	-- -> lspsaa
	-- use {
	--   'filipdutescu/renamer.nvim',
	--   after = 'nvim-lspconfig',
	--   config = function() require 'rc/pluginconfig/renamer' end
	-- }
	-- -> lspsaa
	-- use {
	--   'kosayoda/nvim-lightbulb',
	--   after = 'nvim-lspconfig',
	--   config = function() require 'rc/pluginconfig/nvim-lightbulb' end
	-- }
	-- weilbith/nvim-code-action-menu
	-- RishabhRD/nvim-lsputils
	-- aspeddro/lsp_menu.nvim

	--------------------------------
	-- AI completion
	-- use {'zxqfl/tabnine-vim'}
	use({ "github/copilot.vim", cmd = { "Copilot" } })
	use({
		"zbirenbaum/copilot.lua",
		after = "copilot.vim",
		config = function()
			vim.schedule(function()
				require("copilot")
			end)
		end,
	})

	--------------------------------------------------------------
	-- FuzzyFinders

	--------------------------------
	-- telescope.nvim
	use({
		"nvim-telescope/telescope.nvim",
		-- requires = { { "nvim-lua/plenary.nvim", opt = true }, { "nvim-lua/popup.nvim", opt = true } },
		-- after = { "popup.nvim", "plenary.nvim", colorscheme },
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/telescope")
		end,
	})
	use({
		"nvim-telescope/telescope-frecency.nvim",
		after = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension("frecency")
		end,
	})
	use({
		"nvim-telescope/telescope-github.nvim",
		after = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension("gh")
		end,
	})
	-- use({
	-- 	"nvim-telescope/telescope-project.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("project")
	-- 	end,
	-- })
	-- use({
	-- 	"nvim-telescope/telescope-vimspector.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("vimspector")
	-- 	end,
	-- })
	use({ "nvim-telescope/telescope-symbols.nvim", after = { "telescope.nvim" } })
	-- use({
	-- 	"nvim-telescope/telescope-ghq.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("ghq")
	-- 	end,
	-- })
	use({
		"nvim-telescope/telescope-fzf-writer.nvim",
		after = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension("fzf_writer")
		end,
	})
	use({
		"nvim-telescope/telescope-packer.nvim",
		after = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension("packer")
		end,
	})
	use({
		"nvim-telescope/telescope-smart-history.nvim",
		requires = { { "nvim-telescope/telescope.nvim", opt = true }, { "tami5/sqlite.lua", opt = true } },
		after = { "telescope.nvim", "sqlite.lua" },
		config = function()
			require("telescope").load_extension("smart_history")
		end,
		run = function()
			os.execute("mkdir -p ~/.local/share/nvim/databases/")
		end,
	})
	-- I don't want to set items myself
	-- use { "LinArcX/telescope-command-palette.nvim", 	after = { "telescope.nvim" } }
	-- -> filer
	-- use({
	-- 	"nvim-telescope/telescope-file-browser.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("file_browser")
	-- 	end,
	-- })
	-- use {"sunjon/telescope-arecibo.nvim",
	--   after = {'telescope.nvim'},
	--   rocks = {"openssl", "lua-http-parser"- use({
	-- 	"LinArcX/telescope-command-palette.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("command_palette")
	-- 	end,
	-- })	

	--------------------------------
	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		event = "VimEnter",
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
	-- use({
	-- 	"bryall/contextprint.nvim",
	-- 	after = { "nvim-treesitter" },
	-- 	config = function()
	-- 		require("rc/pluginconfig/contextprint")
	-- 	end,
	-- })
	-- Error on :Gina status
	-- use {
	--   'code-biscuits/nvim-biscuits',
	--   after = {'nvim-treesitter', colorscheme},
	--   config = function() require 'rc/pluginconfig/nvim-biscuits' end
	-- }
	-- -> vim-matchup
	-- use({ "theHamsta/nvim-treesitter-pairs", after = { "nvim-treesitter" } })
	-- use({
	-- 	"nvim-treesitter/playground",
	-- 	after = { "nvim-treesitter" },
	-- })

	--------------------------------
	-- Treesitter textobject & operator
	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = { "nvim-treesitter" } })
	-- incremental-selection
	-- use({ "RRethy/nvim-treesitter-textsubjects", after = { "nvim-treesitter" } })
	use({
		"mizlan/iswap.nvim",
		after = { "nvim-treesitter" },
		config = function()
			require("rc/pluginconfig/iswap")
		end,
	})
	use({
		"mfussenegger/nvim-ts-hint-textobject",
		after = { "nvim-treesitter" },
		config = function()
			require("rc/pluginconfig/nvim-ts-hint-textobject")
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
	use({
		"romgrk/nvim-treesitter-context",
		-- after = {'nvim-treesitter'},
		cmd = { "TSContextEnable" },
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
		"SmiteshP/nvim-gps",
		requires = { { "nvim-treesitter/nvim-treesitter", opt = true } },
		after = "nvim-treesitter",
		config = function()
			require("nvim-gps").setup()
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
	-- use {'powerman/vim-plugin-AnsiEsc', event = "VimEnter"}
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

	--------------------------------
	-- Sidebar
	-- conflict with clever-f (augroup sidebar_nvim_prevent_buffer_override)
	use({
		"GustavoKatel/sidebar.nvim",
		cmd = { "SidebarNvimToggle" },
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

	--------------------------------------------------------------
	-- Search
	
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
	-- Standard Feature Enhancement

	--------------------------------
	-- Programming Languages

	--------------------------------
	-- Markdown
	use({ "iamcco/markdown-preview.nvim", ft = { "markdown" }, run = ":call mkdp#util#install()" })
	-- use markdown-preview.nvim
	-- if vim.fn.executable('glow') then
	--   use {'npxbr/glow.nvim',
	--     ft = {'markdown'},
	--     run = ':GlowInstall',
	--   }
	-- end
	-- use({
	-- 	"SidOfc/mkdx",
	-- 	ft = { "markdown" },
	-- 	setup = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginsetup/mkdx.vim")
	-- 	end,
	-- })
	use({
		"dhruvasagar/vim-table-mode",
		-- event = "VimEnter",
		cmd = { "TableModeEnable" },
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-table-mode.vim")
		end,
	})
	-- slow to build
	-- use {'euclio/vim-markdown-composer',
	--   run = 'cargo build --release'
	-- }

	--------------------------------

end)
