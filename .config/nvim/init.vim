" Fundamentals "{{{
" ---------------------------------------------------------------------

set guifont=Cica:h15
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END
set cursorline
set linespace=7
set encoding=utf-8
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set splitright
set hls
set mouse=a
set shell=fish
set smarttab
set foldmethod=indent
set foldlevel=10
set smartindent

if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif

"}}}


" Terminal setting "{{{
" ---------------------------------------------------------------------
function! s:open(args) abort
    if empty(term_list())
        execute "terminal" a:args
    else
        let bufnr = term_list()[0]
        execute term_getsize(bufnr)[0] . "new"
        execute "buffer + " bufnr
    endif
endfunction

" すでに :terminal が存在していればその :terminal を使用する
command! -nargs=*
\   Terminal call s:open(<q-args>)

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
  runtime ./colors/codedark.vim
  colorscheme codedark
endif

"}}}


" File types " {{
set suffixesadd=.rb,.js,.es,.jsx,.json,.css,.less,.slim,.sass,.styl,.php,.py,.md,.vim,.yml
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
filetype plugin indent on
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


" Neovide theme " {{{
" ---------------------------------------------------------------------

let g:neovide_refresh_rate=140
let g:neovide_transparency=0.9
let g:neovide_cursor_animation_length=0.13
let g:neovide_cursor_trail_length=1.3
let g:neovide_remember_window_size = v:true
let g:neovide_cursor_vfx_particle_speed=15.0
let g:neovide_cursor_vfx_opacity=100.0

" }}}
