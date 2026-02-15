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

local group = vim.api.nvim_create_augroup("SkkeletonTerminalEnterSubmit", { clear = true })

local function should_map_enter_submit(bufnr)
  if vim.bo[bufnr].buftype ~= "terminal" then
    return false
  end

  if vim.bo[bufnr].filetype == "codex" then
    return true
  end

  local name = vim.api.nvim_buf_get_name(bufnr)
  return name:match("^claude%-code") ~= nil
end

local function map_enter_submit(bufnr)
  vim.keymap.set("t", "<CR>", function()
    if vim.fn.exists("*skkeleton#is_enabled") == 1 and vim.fn["skkeleton#is_enabled"]() == 1 then
      local ok, result = pcall(vim.fn["skkeleton#handle"], "handleKey", { ["function"] = "kakutei", expr = true })
      if ok and type(result) == "string" and result ~= "" then
        vim.api.nvim_feedkeys(result, "nit", false)
      end
    end

    local job_id = vim.b[bufnr].terminal_job_id
    if job_id then
      vim.api.nvim_chan_send(job_id, "\r")
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "nt", false)
    end
  end, { buffer = bufnr, silent = true })
end

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  group = group,
  pattern = "*",
  callback = function(ev)
    local bufnr = ev.buf
    if not should_map_enter_submit(bufnr) then
      return
    end
    map_enter_submit(bufnr)
  end,
})
