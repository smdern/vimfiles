let mapleader = ","

" vim-fugitive
map <Leader>gs :Gstatus<cr>
map <Leader>gc :Gcommit<cr>
map <Leader>ga :Git add --all<cr>:Gcommit<cr>
map <Leader>gb :Gblame<cr>
" Automatically remove fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Use j/k in status
function! BufReadIndex()
  setlocal cursorline

  nnoremap <buffer> <silent> j :call search('^#\t.*','W')<Bar>.<CR>
  nnoremap <buffer> <silent> k :call search('^#\t.*','Wbe')<Bar>.<CR>
endfunction
autocmd BufReadCmd  *.git/index exe BufReadIndex()
autocmd BufEnter    *.git/index silent normal gg0j

" Start in insert mode for commit
function! BufEnterCommit()
  normal gg0
  if getline('.') == ''
    start
  end
endfunction
autocmd BufEnter    *.git/COMMIT_EDITMSG  exe BufEnterCommit()

" %% to expand active buffer location on cmdline
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" vim-tmux-navigator
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

" fzf.vim
map <leader>f :FZF<cr>
map <leader>g :GFiles<cr>
map <leader>a :Ag<space>
map <leader>A :Ag! <C-R><C-W><CR>
