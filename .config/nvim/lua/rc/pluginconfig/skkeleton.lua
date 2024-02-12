local dictionaries = {}
-- AquaSkk の共有のバックアップ
local handle = io.popen("ls ~/backup/skk/*")
if handle then
  for line in handle:lines() do
    table.insert(dictionaries, line)
  end
  handle:close()
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'skkeleton-initialize-pre',
  callback = function()
    vim.fn['skkeleton#config']({
      eggLikeNewline = true,
      registerConvertResult = true,
      globalDictionaries = dictionaries,
      -- AquaSKK と共有
      userDictionary = "~/backup/skk/skk-jisyo.utf8"
    })
  end,
  group = vim.api.nvim_create_augroup('SkkeletonInitPre', { clear = true }),
})

