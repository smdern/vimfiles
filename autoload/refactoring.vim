""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! refactoring#PromoteToLet()
  normal! dd
  " :exec '?^\s*it\>'
  normal! P
  .s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  normal ==
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Extract function, highlight w/ V then hit C, type the method name,
" then go down to where you want the method and hit <leader>mp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! refactoring#PasteExtractedFunction()
  set paste
  execute "normal odef \<c-r>.\<cr>\<c-r>\"end"
  set nopaste
  normal v`[=
endfunction
