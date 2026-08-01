local snacks = require("snacks")
local easing = require("snacks.animate.easing")
snacks.setup({
  animate = {
    duration = 80,
    fps = 60,
    easing = easing.linear,
  },
  bigfile = {
    notify = true,
    size = 1.5 * 1024 * 1024,
    line_length = 1000,
  },
  dashboard = {
    enabled = true,
    sections = {
      { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      {
        icon = " ",
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
  },
  gitbrowse = {
    notify = true,
  },
  indent = {
    enabled = true,
    only_scope = true,
    only_current = true,
  },
  lazygit = {
    configure = true,
    config = {
      os = { editPreset = "nvim-remote" },
      gui = {
        -- set to an empty string "" to disable icons
        nerdFontsVersion = "3",
      },
    },
  },
  notifier = {
    enabled = true,
  },
  picker = {
    -- スマートピッカー (rc/keymaps/plugins.lua の <Leader><Leader>)
    smart = {
      multi = { "buffers", "project", "recent", "files" },
      matcher = {
        cwd_bonus = true, -- boost cwd matches
        cwd_weight = 2.0,
        cwd_first = true,
        frecency = true,
        sort_empty = true,
      },
      transform = "unique_file",
    },
    format = "file",
    prompt = " ",
    focus = "input",
    layout = {
      -- 画面が狭いときは vertical に切り替える
      preset = function()
        return vim.o.columns >= 120 and "default" or "vertical"
      end,
    },
    formatters = {
      file = {
        truncate = 40, -- デフォルトは "center"
      },
    },
    previewers = {
      diff = {
        builtin = true, -- Neovim で diff をプレビューする
        cmd = { "delta" },
      },
      git = {
        builtin = true, -- Neovim で git 出力をプレビューする
      },
    },
    -- デフォルトから変えているキーだけを書く。残りは upstream のまま。
    win = {
      input = { keys = { ["q"] = "close" } },
      list = { keys = { ["q"] = "close" } },
      preview = {
        keys = {
          ["q"] = "close",
          ["<ScrollWheelUp>"] = "list_scroll_wheel_up",
          ["<ScrollWheelDown>"] = "list_scroll_wheel_down",
        },
      },
    },
  },
  scroll = {
    animate = {
      duration = { step = 3, total = 200 },
      easing = easing.linear,
    },
    animate_repeat = {
      delay = 50, -- delay in ms before using the repeat animation
      duration = { step = 3, total = 100 },
      easing = easing.inOutQuad,
    },
  },
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.cmd("highlight SnacksIndent guifg=#888888 gui=nocombine")
    vim.cmd("highlight SnacksIndentScope guifg=#cd5c5c gui=nocombine")
  end,
})
