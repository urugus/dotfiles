-- toggleterm の端末バッファ内で gf を押したときに、カーソル下のパスを
-- 通常ウィンドウで開くための処理。折り返しでパスが 2 行に割れることがあるため、
-- 前後の行と連結したものも候補として試す。

local M = {}

---カーソル位置から実在するファイルパスを組み立てる
---@return string
local function file_under_cursor()
  local cur = vim.fn.expand("<cfile>")
  if vim.fn.filereadable(vim.fn.expand(cur)) ~= 0 then
    return cur
  end

  -- 次の行へ折り返している場合
  vim.cmd([[normal! j]])
  local next_line = vim.fn.expand("<cfile>")
  if vim.fn.filereadable(vim.fn.expand(cur .. next_line)) ~= 0 then
    return cur .. next_line
  end

  -- 前の行から折り返してきている場合
  vim.cmd([[normal! 2k]])
  local prev_line = vim.fn.expand("<cfile>")
  if vim.fn.filereadable(vim.fn.expand(prev_line .. cur)) ~= 0 then
    return prev_line .. cur
  end

  vim.cmd([[normal! j]])
  return cur
end

---file:line:col 形式の word から行・桁を拾って開く
---@param file string
---@param word string
local function open_with_position(file, word)
  local found = vim.fn.findfile(file)
  if vim.fn.empty(found) == 1 then
    return
  end

  vim.cmd([[wincmd p]])
  -- スペースや | を含むパスでも壊れないようエスケープする
  vim.cmd.edit(vim.fn.fnameescape(found))

  local line = vim.fn.matchstr(word, file .. ":" .. "\\zs\\d*\\ze")
  if vim.fn.empty(line) == 1 then
    return
  end
  vim.fn.execute(line)

  local col = vim.fn.matchstr(word, file .. ":\\d*:" .. "\\zs\\d*\\ze")
  if vim.fn.empty(col) ~= 1 then
    vim.fn.execute("normal! " .. col .. "|")
  end
end

---端末バッファの gf。フロート表示中なら先に端末を閉じる。
function M.goto_file_from_terminal()
  local file = file_under_cursor()
  local word = vim.fn.expand("<cWORD>")

  if vim.fn.has_key(vim.api.nvim_win_get_config(vim.fn.win_getid()), "anchor") ~= 0 then
    vim.cmd([[ToggleTerm]])
  end

  open_with_position(file, word)
end

return M
