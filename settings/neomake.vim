let g:neomake_warning_sign = {
  \ 'text': '⚠',
  \ 'texthl': 'WarningMsg',
  \ }
let g:neomake_error_sign = {
  \ 'text': '✖',
  \ 'texthl': 'ErrorMsg',
  \ }
let g:neomake_open_list = 2
let g:neomake_list_height = 5

let g:neomake_javascript_enabled_makers = ['eslint_d', 'flow']
let g:neomake_jsx_enabled_makers = ['eslint_d', 'flow']

let g:neomake_javascript_flow_exe = g:flow_path
let g:neomake_jsx_flow_exe = g:flow_path

let g:neomake_elixir_mix_maker = {
  \ 'exe': 'mix',
  \ 'args': ['compile', '%:p', '--warnings-as-errors'],
  \ 'errorformat':
  \ '** %s %f:%l: %m,' .
  \ '%f:%l: warning: %m'
  \ }

let g:neomake_elixir_lint_maker = {
  \ 'exe': 'mix',
  \ 'args': ['credo', 'list', '%:p', '--one-line', '-i', 'readability'],
  \ 'errorformat': '[%t] %. %f:%l:%c %m'
  \ }

let g:neomake_elixir_enabled_makers = ['mix', 'lint']


autocmd! BufWritePost * Neomake
