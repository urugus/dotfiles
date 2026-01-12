-- AquaSKK の辞書と同じものを参照させる
local aquaskk_dir = vim.fn.expand("~/Library/Application Support/AquaSKK")
local dictionaries = {}

-- システム辞書を設定（SKK-JISYO.* パターン）
local dict_files = vim.fn.glob(aquaskk_dir .. "/SKK-JISYO.*", false, true)
for _, dict in ipairs(dict_files) do
  table.insert(dictionaries, dict)
end

-- ユーザー辞書のパス
local user_dict = aquaskk_dir .. "/skk-jisyo.utf8"

vim.api.nvim_create_autocmd("User", {
  pattern = "skkeleton-initialize-pre",
  callback = function()
    vim.fn["skkeleton#config"]({
      eggLikeNewline = true,
      registerConvertResult = true,
      globalDictionaries = dictionaries,
      userDictionary = user_dict,
    })
  end,
  group = vim.api.nvim_create_augroup("SkkeletonInitPre", { clear = true }),
})

-- ターミナルモード用キーマッピング
vim.keymap.set("t", "<C-j>", "<Plug>(skkeleton-toggle)")
