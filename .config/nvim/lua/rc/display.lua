-- nvim color
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

vim.o.synmaxcol = 200
-- ColorScheme
vim.cmd([[ syntax enable ]]) -- シンタックスカラーリングオン
-- vim.o.t_Co = 256
vim.o.background = "dark"

-- true color support
vim.g.colorterm = os.getenv("COLORTERM")
if
	vim.g.colorterm == "truecolor"
	or vim.g.colorterm == "24bit"
	or vim.g.colorterm == "rxvt"
	or vim.g.colorterm == ""
then
	if vim.fn.exists("+termguicolors") then
		vim.o.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
		vim.o.t_8b = "<Esc>[48;2;%lu;%lu;%lum"
		vim.o.termguicolors = true
	end
end

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
