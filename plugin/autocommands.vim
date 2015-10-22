function! <SID>StripTrailingWhitespaces()
  " Save last search and cursor position
  let reg = getreg('/')
  let pos = getpos('.')
  " Join to the previous command so we don't get into
  " an undo loop with auto save
  silent! undojoin

  execute '%s/\s\+$//e'

  " Restore last search and cursor position
  call setreg('/', reg)
  call setpos('.', pos)
endfunction

augroup Miscellaneous
  au!
  " Remember last location in file
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif

  " Remove trailing whitespace
  au FileType coffee,eruby,haml,javascript,php,ruby,sass,scss,sh,xml
        \ au BufWritePre <buffer>
        \ call <SID>StripTrailingWhitespaces()
augroup END
