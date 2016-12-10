let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~30%' }

map <leader>f :FZF!<cr>
map <leader>g :GFiles<cr>
map <leader>a :Ag<space>
map <leader>A :Ag! <C-R><C-W><CR>
