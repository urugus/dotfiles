local M = {}

-- 一括でキーマップを定義するヘルパー
-- maps = { {mode, lhs, rhs, opts?}, ... }
--
-- opts の noremap / silent は明示的に false を渡さない限り true になるので、
-- 大半のエントリは opts を省略できる。remap = true を渡した場合は
-- vim.keymap.set 側が noremap を打ち消すため、プレフィックスの別名定義に使える。
-- bufnr を渡すとバッファローカルなマップになる。
function M.set(maps, bufnr)
  for _, map in ipairs(maps) do
    local mode, lhs, rhs, opts = map[1], map[2], map[3], map[4] or {}
    if opts.remap == nil then
      opts.noremap = opts.noremap ~= false
    end
    opts.silent = opts.silent ~= false
    if bufnr then
      opts.buffer = bufnr
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

return M
