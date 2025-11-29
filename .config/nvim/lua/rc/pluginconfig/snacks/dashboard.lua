-- Dashboard configuration for snacks.nvim
local snacks = require("snacks")

return {
  enabled = true,
  sections = {
    { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
    { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
    {
      icon = " ",
      title = "Git Status",
      section = "terminal",
      enabled = function()
        return snacks.git.get_root() ~= nil
      end,
      cmd = "git status --short --branch --renames",
      height = 5,
      padding = 1,
      ttl = 5 * 60,
      indent = 3,
    },
    { section = "startup" },
  },
}
