local M = {}

function M.setup()
  require("rc.keymaps.core")()
  require("rc.keymaps.plugins")()
  require("rc.keymaps.ft").setup()
end

return M
