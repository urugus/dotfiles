let g:ctrlp_map = '<Nop>'
nnoremap <leader>p :<C-u>CtrlPMixed<CR>
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:ctrlp_open_new_file       = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_mruf_max            = 50
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif
