local animate = require("mini.animate")
animate.setup({
  -- No need to copy this inside `setup()`. Will be used automatically.
  -- Cursor path
  cursor = {
    -- Whether to enable this animation
    enable = true,

    -- Timing of animation (how steps will progress in time)
    timing = animate.gen_timing.linear({ duration = 80, unit = 'total' }),
    --
    -- -- Path generator for visualized cursor movement
    -- path = --<function: implements shortest line path>,
  },

  -- Vertical scroll
  scroll = {
    -- Whether to enable this animation
    enable = true,

    -- Timing of animation (how steps will progress in time)
    timing = animate.gen_timing.linear({ duration = 100, unit = 'total' }),
    --
    -- -- Subscroll generator based on total scroll
    -- subscroll = --<function: implements equal scroll with at most 60 steps>,
  },

  -- Window resize
  resize = {
    -- Whether to enable this animation
    enable = true,

    -- Timing of animation (how steps will progress in time)
    timing = animate.gen_timing.linear({ duration = 80, unit = 'total' }),
    --
    -- -- Subresize generator for all steps of resize animations
    -- subresize = --<function: implements equal linear steps>,
  },

  -- Window open
  open = {
    -- Whether to enable this animation
    enable = true,
    --
    -- -- Timing of animation (how steps will progress in time)
    -- timing = --<function: implements linear total 250ms animation duration>,
    --
    -- -- Floating window config generator visualizing specific window
    -- winconfig = --<function: implements static window for 25 steps>,
    --
    -- -- 'winblend' (window transparency) generator for floating window
    -- winblend = --<function: implements equal linear steps from 80 to 100>,
  },

  -- Window close
  close = {
    -- Whether to enable this animation
    enable = true,
    --
    -- -- Timing of animation (how steps will progress in time)
    -- timing = --<function: implements linear total 250ms animation duration>,
    --
    -- -- Floating window config generator visualizing specific window
    -- winconfig = --<function: implements static window for 25 steps>,
    --
    -- -- 'winblend' (window transparency) generator for floating window
    -- winblend = --<function: implements equal linear steps from 80 to 100>,
  },
})
