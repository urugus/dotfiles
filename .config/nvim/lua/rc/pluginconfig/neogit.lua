local neogit = require("neogit")
neogit.setup({
  kind = "tab",
  commit_popup = {
    kind = "split",
  },
  disable_commit_confirmation = true,
  disable_insert_on_commit = true,
  integrations = { diffview = true },
  sections = {
    stashes = {
      folded = false,
    },
    recent = { folded = false },
  },
})

-- キーマップ ([git]s) は rc/keymaps/plugins.lua にある
