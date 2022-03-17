let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\}
let g:ale_linters = {
\   'ruby': ['rubocop'],
\}
let g:ale_ruby_rubocop_executable = 'bin/rubocop'
let g:ale_ruby_rubocop_options = '-D'
let g:ale_lint_on_text_changed = 1
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_linters_explicit = 1 
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️ '
