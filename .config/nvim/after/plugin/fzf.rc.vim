" keymaps " {{{
"-----------------------------------
nnoremap <leader>p :Files<CR>
nnoremap <leader>f :Rg<CR>
nnoremap <silent><leader>ag :Rg <C-R><C-W><CR>
nnoremap <leader>gs :GFiles?<CR>
nnoremap <leader>mp :Maps<CR>

"-----------------------------------
" }}}


" keymaps " {{{
"-----------------------------------
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
"-----------------------------------
" }}}
