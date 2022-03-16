" if exists("g:loaded_runrspec")
"   finish
" endif
let g:run_rspec_bin = 'bundle exec rspec'
let g:loaded_runrspec = 1

let s:save_cpo = &cpo
set cpo&vim


command! RunSpec call runrspec#rspec_current_file()
command! RunSpecLine call runrspec#rspec_current_line()
command! RunSpecLastRun call runrspec#rspec_last_run()
command! RunSpecCloseResult call runrspec#close_result_window()

" run-rspec
nnoremap <leader>rt :RunSpec<CR>
nnoremap <leader>rl :RunSpecLine<CR>
nnoremap <leader>rc :RunSpecCloseResult<CR>
nnoremap <leader>it :IndentGuidesToggle<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
