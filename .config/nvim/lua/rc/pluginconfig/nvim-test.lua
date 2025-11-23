require("nvim-test").setup({
  run = true,
  term = "toggleterm",
  termOpts = {
    direction = "float",
    keep_one = true,
  },
  runners = {
    ruby = "nvim-test.runners.rspec",
  },
})
require("nvim-test.runners.rspec"):setup({
  command = "bundle exec rspec", -- a command to run the test runner
  -- file_pattern = "spec(\w)+(spec\.rb)$",   -- determine whether a file is a testfile
  -- find_files = "spec(\w)+{name}(_spec\.rb)$",
  -- filename_modifier = nil,                                                    -- modify filename before tests run (:h filename-modifiers)
  -- working_directory = nil,                                                    -- set working directory (cwd by default)
})
