local ufo = require("ufo")

-- Base config
vim.o.foldcolumn = "0" -- フォールドのカラムを表示
vim.o.foldlevel = 99 -- 初期のフォールドレベル
vim.o.foldlevelstart = 99 -- 起動時のフォールドレベル
vim.o.foldenable = true -- フォールドを有効化

-- UFO のセットアップ
ufo.setup({
  provider_selector = function(_, _, _)
    return { "lsp", "indent" }
  end,
  fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (" 󰁂 %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0

    for _, chunk in ipairs(virtText) do
      local chunkText, chunkHl = chunk[1], chunk[2]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        table.insert(newVirtText, { chunkText, chunkHl })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
  end,
})

-- Keymaps
vim.keymap.set("n", "[ufo]R", ufo.openAllFolds, { desc = "Open all folds" })
vim.keymap.set("n", "[ufo]M", ufo.closeAllFolds, { desc = "Close all folds" })
vim.keymap.set("n", "[ufo]r", ufo.openFoldsExceptKinds, { desc = "Open folds except kinds" })
vim.keymap.set("n", "[ufo]m", ufo.closeFoldsWith, { desc = "Close folds with level" })
