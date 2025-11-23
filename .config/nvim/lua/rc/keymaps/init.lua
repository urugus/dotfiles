local M = {}

function M.setup()
  require("rc.keymaps.core")()
  require("rc.keymaps.plugin")()
  require("rc.keymaps.ft").setup()
end

return M
