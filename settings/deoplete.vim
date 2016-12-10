"== Shougo/deoplete.nvim ==
" == carlitux/deoplete-ternjs ==
let g:deoplete#enable_at_startup = 1

if g:flow_path != 'flow not found'
  let g:deoplete#sources#flow#flow_bin = g:flow_path
endif

let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0
set completeopt-=preview
