if !g:expandWindows
  finish
endif

" Make the window we're on as big as it makes sense to make it
set winwidth=84

" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Special window size hack
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ResizeWindow()
  if &previewwindow
    set winheight=999
  elseif &buftype == 'quickfix'
    set winheight=10
  else
    set winheight=999
  endif
endfunction
autocmd WinEnter * call ResizeWindow()
