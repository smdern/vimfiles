let g:neomake_warning_sign = {
\ 'text': 'W',
\ 'texthl': 'WarningMsg',
\ }
let g:neomake_error_sign = {
\ 'text': 'E',
\ 'texthl': 'ErrorMsg',
\ }
let g:neomake_javascript_enabled_makers = ['eslint_d', 'flow']
let g:neomake_jsx_enabled_makers = g:neomake_javascript_enabled_makers
let g:neomake_elixir_enabled_makers = ['elixir', 'credo']
let g:neomake_javascript_flow_exe = g:flow_path
let g:neomake_jsx_flow_exe = g:flow_path
