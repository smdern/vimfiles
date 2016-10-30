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

let g:neomake_elixir_enabled_makers = ['elixir', 'credo']

autocmd! BufWritePost * Neomake
