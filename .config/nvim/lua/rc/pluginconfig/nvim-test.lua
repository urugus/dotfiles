require("nvim-test").setup {
  run = true,
  term = "toggleterm",
  runners = {
    ruby = "nvim-test.runners.rspec"
  }
}
