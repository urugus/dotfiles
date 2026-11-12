local cmp = require("cmp")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  -- 補完は markdown でのみ使う (プラグイン自体も ft = "markdown" で読み込む)
  enabled = function()
    return vim.bo.filetype == "markdown"
  end,
  mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<Up>"] = cmp.mapping(function(_)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      else
        vim.api.nvim_feedkeys(t("<Up>"), "n", true)
      end
    end),
    ["<Down>"] = cmp.mapping(function(_)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        vim.api.nvim_feedkeys(t("<Down>"), "n", true)
      end
    end),
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      end

      if has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end),
    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-y>"] = cmp.config.disable,
    ["<C-q>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  },
  sources = cmp.config.sources({
    { name = "skkeleton", priority = 80 },
    { name = "nvim_lsp", priority = 100 }, -- render-markdown の in-process LSP (チェックボックス / callout)
    { name = "path", priority = 100 },
  }, {
    { name = "buffer", priority = 50 },
  }),
})
