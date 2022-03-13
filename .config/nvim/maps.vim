" Description: Keymaps

" Set leader to Space-key
let mapleader = "\<Space>"


" Text edit"{{{
"-----------------------------

" Change line
nnoremap <S-C-p> "0p
" Delete without yank
nnoremap <leader>d "_d
nnoremap x "_x

" Increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

" Delete a word backwards
nnoremap dw vb"_d

" Select all
nmap <C-a> gg<S-v>G

" Save with root permission
command! W w !sudo tee > /dev/null %

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" }}}


" Tab" {{{
"-----------------------------

nmap te :tabedit
nmap <silent><S-j> :tabprev<Return>
nmap <silent><S-k> :tabnext<Return>
nmap <silent>T :tabnew#<CR>

" }}}

" Windows" {{{
"------------------------------

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
" Move window
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l
" Resize window
nmap <C-w><right> 3<C-w>>
nmap <C-w><left> 3<C-w><
nmap <C-w><up> 3<C-w>+ 
nmap <C-w><down> 3<C-w>-

" }}}


" Terminal" {{{
"------------------------------

command! -nargs=* T split | wincmd j | resize 20 | terminal <args>
nnoremap <leader>t :T<CR>
autocmd TermOpen * startinsert
tnoremap <Esc> <C-\><C-n>
" }}}

" Plugins" {{{
"------------------------------

" ctrlp
let g:ctrlp_map = '<c-p>'

" coc
"
nmap gd (coc-definition)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nnoremap <silent> gp :bprevious<CR>
nnoremap <silent> gn :bnext<CR>

" defx
nnoremap <silent> <Leader>f :<C-u> Defx <CR>

" }}}

" Others" {{{
"------------------------------

" }}}
