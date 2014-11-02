augroup Miscellaneous
  au!
  " Remember last location in file
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif

  " Remove trailing whitespace
  au FileType coffee,eruby,haml,javascript,php,ruby,sass,scss,sh,xml
    \ au BufWritePre <buffer>
      \ let pos = getpos('.')
      \ | execute '%s/\s\+$//e'
      \ | call setpos('.', pos)
augroup END
