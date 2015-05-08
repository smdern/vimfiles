" CTags
map <Leader>rt :!ctags --tag-relative --fields=+l --extra=+fq -R --languages=-javascript,sql *<CR><CR>
map <C-\> :tnext<CR>

" Inserts the path of the currently edited file into a command
" Command mode: %%
cmap %% <C-R>=expand("%:p:h") . "/" <CR>

" map quick quit
map <leader>qq :qa!<cr>

" Make the current directory
nmap <leader>md :silent !mkdir -p %:h<CR>:redraw!<CR>

function! SaveIfModified()
  if &modified
    :w
  endif
endfunction

nmap <leader>rr :redraw!<CR>

" key mapping for error navigation
nmap <leader>[ :call SaveIfModified()<CR>:cprev<CR>
nmap <leader>] :call SaveIfModified()<CR>:cnext<CR>

" key mapping for ; and , since they do other things now and I don't use marks
nnoremap m ;
nnoremap M ,

" Copy paste system clipboard
map <leader>y "*y
map <leader>p "*p
map <leader>P "*P
map <leader>gr "*gr
