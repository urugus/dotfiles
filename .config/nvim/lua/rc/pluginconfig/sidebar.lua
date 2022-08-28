require("sidebar-nvim").setup({
	disable_default_keybindings = 0,
	bindings = {
		["q"] = function()
			require("sidebar-nvim").close()
		end,
	},
	files = {
		icon = "",
		show_hidden = false,
		ignored_paths = {"%.git$"}
        },
	open = false,
	side = "right",
	initial_width = 35,
	update_interval = 1000,
	section_separator = "-----",
})

vim.api.nvim_set_keymap("n", "bx", "<Cmd>SidebarNvimToggle<CR>", { noremap = true, silent = true })
