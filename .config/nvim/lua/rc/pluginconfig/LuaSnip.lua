local ls = require("luasnip")
local types = require("luasnip.util.types")

-- キーマップ (<C-Down>) は rc/keymaps/plugins.lua にある
ls.setup({
  keep_roots = true,
  link_roots = true,
  link_children = true,
  updateevents = "TextChanged,TextChangedI",
  -- history を有効にしていると、消されたスニペットの検出タイミングが要る
  delete_check_events = "TextChanged",
  ext_opts = { [types.choiceNode] = { active = { virt_text = { { "choiceNode", "Comment" } } } } },
  -- treesitter-hl が 100 なので、それより高くする (デフォルトは 200)
  ext_base_prio = 300,
  ext_prio_increase = 1,
  enable_autosnippets = true,
  -- markdown コードブロックなどで正しい filetype を解決するため split する
  ft_func = function()
    return vim.split(vim.bo.filetype, ".", true)
  end,
})

-- lua ファイルでは lua → c → all の順にスニペットを探す
ls.filetype_extend("lua", { "c" })
ls.filetype_set("cpp", { "c" })
-- honza/vim-snippets のグローバルスニペットは "_" に入る
ls.filetype_extend("all", { "_" })
