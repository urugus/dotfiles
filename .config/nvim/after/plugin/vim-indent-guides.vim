let g:indent_guides_enable_on_vim_startup = 1
set ts=2 sw=2 et
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_color_change_percent = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=NONE
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#373737
