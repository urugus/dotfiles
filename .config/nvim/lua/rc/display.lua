-- nvim color
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.o.synmaxcol = 200
-- ColorScheme
vim.cmd([[ syntax enable ]]) -- シンタックスカラーリングオン
-- vim.o.t_Co = 256
vim.g.transparency = 0.7
vim.o.background = "dark"

-- colorscheme pluginconfig -> colorscheme
vim.o.cursorline = false

vim.o.display = "lastline" -- 長い行も一行で収まるように
vim.o.showmode = false
vim.o.showmatch = true -- 括弧の対応をハイライト
vim.o.matchtime = 1 -- 括弧の対を見つけるミリ秒数
vim.o.showcmd = true -- 入力中のコマンドを表示
vim.o.number = true -- 行番号表示
vim.o.relativenumber = true
vim.o.wrap = true -- 画面幅で折り返す
vim.o.title = false -- タイトル書き換えない
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
vim.o.pumheight = 10 -- 補完候補の表示数

-- 折りたたみ設定
-- vim.o.foldmethod="marker"
vim.o.foldmethod = "manual"
vim.o.foldlevel = 1
vim.o.foldlevelstart = 99
vim.w.foldcolumn = "0:"

-- font
vim.o.guifont = "UDEV Gothic LG:style=Regular:size=12"

-- Cursor style
vim.o.guicursor = "n-v-c-sm:block-Cursor/lCursor-blinkon0,i-ci-ve:ver25-Cursor/lCursor,r-cr-o:hor20-Cursor/lCursor"

vim.o.cursorlineopt = "number"

-- ステータスライン関連
-- vim.o.laststatus = 2
vim.o.laststatus = 3
vim.o.shortmess = "aItToOF"
vim.opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}


-- ===============================
-- Editor Configuration
-- ===============================
-- neovide
if vim.fn.exists("g:neovide") then
  vim.g.neovide_cursor_animation_length = 0.13
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_transparency = 0.7
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 20
  vim.g.neovide_light_angle_degree = 45
  vim.g.neovide_light_radius = 5
  vim.g.neovide_font = 'UDEV Gothic LG'
  vim.g.neovide_default_font_size = 12
end

