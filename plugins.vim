call plug#begin('~/.vim/plugged')



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Plug 'christoomey/vim-tmux-navigator'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'
Plug 'janko-m/vim-test'
Plug 'rizzatti/dash.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tomtom/tcomment_vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-endwise'
Plug 'rstacruz/vim-closer'
Plug 'ludovicchabant/vim-gutentags'
Plug 'benekastah/neomake'
Plug 'jszakmeister/vim-togglecursor'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  Plug 'steelsojka/deoplete-flow', { 'for': ['javascript', 'javascript.jsx'] }

  Plug 'kassio/neoterm'
else
  Plug 'Valloric/YouCompleteMe', {
        \ 'for': ['elixir', 'eelixir', 'javascript', 'javascript.jsx'],
        \ 'do': './install.py --tern-completer'
        \}
  Plug 'larrylv/ycm-elixir', { 'for': ['elixir', 'eelixir'] }
  Plug 'flowtype/vim-flow', { 'for': ['javascript', 'javascript.jsx'] }

  Plug 'tpope/vim-dispatch'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Elixir
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'slashmili/alchemist.vim', { 'for': ['elixir', 'eelixir'] }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetypes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'sheerun/vim-polyglot'

call plug#end()
