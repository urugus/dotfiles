-- 辞書を探す
local dictionaries = {}
-- AquaSkk の辞書と同じものを参照させる
local handle = io.popen("ls ~/Library/Application\\ Support/AquaSKK/*")
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
    })
  end,
  group = vim.api.nvim_create_augroup('SkkeletonInitPre', { clear = true }),
})
