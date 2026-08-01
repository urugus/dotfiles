local function copilot_status()
  -- Copilot の有効状態を取得
  if vim.fn["copilot#Enabled"]() == 1 then
    return ""
  end
  return ""
end

local sections_1 = {
  lualine_a = { "mode" },
  lualine_b = { { "filetype", icon_only = true }, { "filename", path = 1 } },
  lualine_c = {},
  lualine_x = { "diagnostics", copilot_status },
  lualine_y = { "branch", "diff" },
  lualine_z = { "location" },
}

local sections_2 = {
  lualine_a = { "mode" },
  lualine_b = { "" },
  lualine_c = { { "filetype", icon_only = true }, { "filename", path = 1 } },
  lualine_x = { "encoding", "fileformat", "filetype" },
  lualine_y = { "filesize", "progress" },
  lualine_z = { "location" },
}

-- キーマップ (<Leader>ul) は rc/keymaps/plugins.lua にある
vim.api.nvim_create_user_command("LualineToggle", function()
  local lualine_require = require("lualine_require")
  local modules = lualine_require.lazy_require({ config_module = "lualine.config" })
  local utils = require("lualine.utils.utils")

  local current_config = modules.config_module.get_config()
  if vim.inspect(current_config.sections) == vim.inspect(sections_1) then
    current_config.sections = utils.deepcopy(sections_2)
  else
    current_config.sections = utils.deepcopy(sections_1)
  end
  require("lualine").setup(current_config)
end, { desc = "Toggle lualine sections" })

-- nordfox
local colors = {
  black = "#3b4252",
  red = "#bf616a",
  green = "#a3be8c",
  yellow = "#ebcb8b",
  blue = "#81a1c1",
  magenta = "#b48ead",
  cyan = "#88c0d0",
  white = "#e5e9f0",
  foreground = "#b9bfca",
  background = "#2e3440",
}

local terminal_status_colors = {
  Running = colors.yellow,
  Finished = colors.magenta,
  Success = colors.blue,
  Error = colors.red,
  Command = colors.green,
}

local function get_exit_status()
  local ln = vim.api.nvim_buf_line_count(0)
  while ln >= 1 do
    local l = vim.api.nvim_buf_get_lines(0, ln - 1, ln, true)[1]
    ln = ln - 1
    local exit_code = string.match(l, "^%[Process exited ([0-9]+)%]$")
    if exit_code ~= nil then
      return tonumber(exit_code)
    end
  end
end

-- :ls! のフラグ (F = 終了した端末ジョブ, R = 実行中) で現在のバッファを絞り込む。
-- vim.cmd("echo ...") は出力をメッセージ領域へ出すだけで戻り値が常に "" になるため、
-- 出力を受け取れる vim.fn.execute を使う。
local function terminal_buffer_matches(flag)
  local name = vim.fn.escape(vim.api.nvim_buf_get_name(0), "~/")
  local ok, out = pcall(vim.fn.execute, "filter /" .. name .. "/ ls! ua" .. flag)
  return ok and vim.trim(out) ~= ""
end

local function terminal_status()
  if terminal_buffer_matches("F") then
    local result = get_exit_status()
    if result == 0 then
      return "Success"
    elseif result ~= nil and result >= 1 then
      return "Error"
    end
    return "Finished"
  end
  if terminal_buffer_matches("R") then
    return "Running"
  end
  return "Command"
end

local function get_terminal_status()
  if vim.bo.buftype ~= "terminal" then
    return ""
  end
  local status = terminal_status()
  vim.api.nvim_set_hl(0, "LualineToggleTermStatus", {
    fg = colors.background,
    bg = terminal_status_colors[status],
  })
  return status
end

local function toggleterm_statusline()
  return "ToggleTerm #" .. tostring(vim.b.toggle_number)
end

local my_toggleterm = {
  sections = {
    lualine_a = { toggleterm_statusline },
    lualine_z = { { get_terminal_status, color = "LualineToggleTermStatus" } },
  },
  filetypes = { "toggleterm" },
}

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "vscode",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = sections_1,
  inactive_sections = {
    lualine_a = { "mode" },
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "quickfix", my_toggleterm },
})
