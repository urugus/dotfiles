local M = {}

-- 一括でキーマップを定義するヘルパー
-- maps = { {mode, lhs, rhs, opts}, ... }
function M.set(maps)
  for _, map in ipairs(maps) do
    local mode, lhs, rhs, opts = map[1], map[2], map[3], map[4] or {}
    local plugin = opts.plugin
    opts.plugin = nil

    -- プラグイン名が指定されている場合は、定義時に lazy.nvim で読み込んでおく
    if plugin then
      local ok, lazy = pcall(require, "lazy")
      if ok and lazy and lazy.load then
        lazy.load({ plugins = { plugin } })
      end
    end

    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- バッファローカルな LSP マップ用のヘルパー
function M.set_buf(bufnr, maps)
  for _, map in ipairs(maps) do
    local mode, lhs, rhs, opts = map[1], map[2], map[3], map[4] or {}
    opts.buffer = bufnr
    opts.noremap = opts.noremap ~= false
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

return M
