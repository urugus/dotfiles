let g:far#enable_undo=2
" farの検索をrgにする
let g:far#source="rgnvim"
set lazyredraw            " improve scrolling performance when navigating through large results
set regexpengine=1        " use old regexp engine
set ignorecase smartcase  " ignore case only when the pattern contains no capital letters
" ショートカット設定
" ctrl + g で置換のショートカット
nnoremap <C-g> :Far  **/*<Left><Left><Left><Left><Left>
" ctrl + s で検索のショートカット
nnoremap <C-s> :F  **/*<Left><Left><Left><Left><Left>
let g:far#window_layout="tab"
