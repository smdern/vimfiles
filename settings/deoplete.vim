function! StrTrim(txt)
  return substitute(a:txt, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
endfunction

let g:flow_path = StrTrim(system('PATH=$(npm bin):$PATH && which flow'))

let g:deoplete#enable_at_startup = 1
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:deoplete#sources#flow#flow_bin = g:flow_path
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0
set completeopt-=preview
