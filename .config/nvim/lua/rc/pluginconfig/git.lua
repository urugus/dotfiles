local git = require("git")

git.setup({
  keymaps = {
    -- Open blame window
    blame = "[git]gb",
    -- Open file/folder in git repository
    browse = "[git]go",
  },
})
