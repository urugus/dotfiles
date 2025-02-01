require("no-neck-pain").setup({
  autocmds = {
    enableOnVimEnter = false,
  },
  buffers = {
    scratchPad = {
      enabled = true,
      location = "./.idea/"
    },
    bo = {
      filetype = "md"
    }
  },
  bufferOptionsScratchPad = {
    enabled = true,
    fileName = "memo.md",
    pathToFile = "./.idea/"
  },
  disableOnLastBuffer = true,
  killAllBuffersOnDisable = false,
  width = 200,
})
