" Fundamentals "{{{
" ---------------------------------------------------------------------
autocmd VimEnter * execute 'Defx'

set guifont=DroidSansMono\ Nerd\ Font:h12
set number             "行番号を表示
set encoding=utf-8
set autoindent         "改行時に自動でインデントする
set tabstop=2          "タブを何文字の空白に変換するか
set shiftwidth=2       "自動インデント時に入力する空白の数
set expandtab          "タブ入力を空白に変換
set splitright         "画面を縦分割する際に右に開く
set hls                "検索した文字をハイライトする
set mouse=a
set shell=fish
set smarttab

" Don't redraw while executing macros (good performance config)
set lazyredraw
" }}}




if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif

"}}}

" Syntax theme "{{{
" ---------------------------------------------------------------------

" true color
if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  " Use NeoSolarized
  let g:neosolarized_termtrans=1
  runtime ./colors/NeoSolarized.vim
  colorscheme NeoSolarized
endif

"}}}


" File types " {{
set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
"}}}


" Imports "{{{
" ---------------------------------------------------------------------
runtime ./plug.vim
if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n"
    runtime ./macos.vim
  endif
endif

runtime ./maps.vim
"}}}


" Neovide them " {{{
" ---------------------------------------------------------------------
let g:neovide_refresh_rate=140
let g:neovide_transparency=0.8
let g:neovide_cursor_animation_length=0.18
let g:neovide_cursor_trail_length=1.3

" }}}



