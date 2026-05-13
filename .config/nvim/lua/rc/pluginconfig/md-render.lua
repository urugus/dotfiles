local M = {}

local chrome_path = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

local function is_zellij()
  return vim.env.ZELLIJ ~= nil and vim.env.ZELLIJ ~= ""
end

local function setup_puppeteer_chrome()
  if not vim.env.PUPPETEER_EXECUTABLE_PATH and vim.fn.executable(chrome_path) == 1 then
    vim.env.PUPPETEER_EXECUTABLE_PATH = chrome_path
  end
end

local function disable_terminal_images_in_zellij()
  if not is_zellij() then
    return
  end

  local ok, image = pcall(require, "md-render.image")
  if ok and image._set_kitty_supported then
    image._set_kitty_supported(false)
  end
end

local function max_width(width)
  return math.max(40, width - 2)
end

local function float_max_width()
  return max_width(math.floor(vim.o.columns * 0.8))
end

local function tab_max_width()
  return max_width(vim.o.columns)
end

local function split_max_width(vertical)
  local width = vim.api.nvim_win_get_width(0)
  if vertical then
    width = math.floor(width / 2)
  end
  return max_width(width)
end

function M.float()
  require("md-render").preview.show({ max_width = float_max_width() })
end

function M.tab()
  require("md-render").preview.show_tab({ max_width = tab_max_width() })
end

function M.split()
  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0)
  local vertical = width >= height
  local mods = vertical and { vertical = true } or {}
  require("md-render").preview.split({ mods = mods, max_width = split_max_width(vertical) })
end

function M.setup()
  setup_puppeteer_chrome()
  disable_terminal_images_in_zellij()

  vim.api.nvim_create_user_command("MdRender", M.float, { desc = "Markdown preview in floating window" })
  vim.api.nvim_create_user_command("MdRenderTab", M.tab, { desc = "Markdown preview in tab" })
  vim.api.nvim_create_user_command("MdRenderSplit", M.split, { desc = "Markdown preview in split" })
end

return M
