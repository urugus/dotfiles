-- UI-related configuration for snacks.nvim (animate, indent, scroll, etc.)
local easing = require("snacks.animate.easing")

return {
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
        nerdFontsVersion = "3",
      },
    },
  },
  notifier = {
    enabled = true,
  },
  scroll = {
    animate = {
      duration = { step = 3, total = 200 },
      easing = easing.linear,
    },
    animate_repeat = {
      delay = 50,
      duration = { step = 3, total = 100 },
      easing = easing.inOutQuad,
    },
  },
}
