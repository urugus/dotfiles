local lspsaga = require("lspsaga")
lspsaga.setup({ -- defaults ...
  -- use emoji lightbulb in default
  code_action_icon = "󱧡",
  -- custom finder title winbar function type
  -- param is current word with symbol icon string type
  -- return a winbar format string like `%#CustomFinder#Test%*`
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    table = "t",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>", -- quit can be a table
  },
})
