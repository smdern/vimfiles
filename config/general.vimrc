if has('termguicolors')
  set termguicolors
endif

if has('vim_starting')
 if &compatible
   set nocompatible
 endif
endif

if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
end

if has('gui_running')
  " MacVIM shift+arrow-keys behavior (required in .vimrc)
  let macvim_hig_shift_movement = 1
end

let mapleader = ","

syntax on

let g:rehash256 = 1
let g:molokai_original = 1

color molokai

" Backups and swap
set nobackup
set nowritebackup
set noswapfile
set backupdir=~/.vim/backup
set directory=~/.vim/backup

syntax on
set nohidden
set history=10000
set number
set ruler
set switchbuf=useopen
set encoding=utf-8

" Use bash because it's fast, zsh loads too slow w/ rvm
let $BASH_ENV = "~/.bash/env"
set shell=bash

" Whitespace and Wrapping
"                 +-> Auto-wrap comments using textwidth
"                 |+-> Allow formatting of comments with 'gq'
"                 ||+-> Automatically insert the current comment leader after
"                 |||   hitting Enter in Insert mode
"                 |||+-> Remove comment leaders when joining lines
set formatoptions=cqrj
set nowrap
set list listchars=tab:\ \ ,trail:·

" tab stuff
set tabstop=2
set softtabstop=2
set expandtab
set smarttab
set shiftwidth=2
set autoindent
set smartindent

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=longest,list
set wildmenu
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,public/javascripts/compiled
set wildignore+=tmp,*.orig,*.jpg,*.png,*.gif,log,solr,.sass-cache,.jhw-cache
set wildignore+=bundler_stubs,build,error_pages,bundle,build,error_pages

" Status bar
set laststatus=2

" Show (partial) command in the status line
set showcmd

set noerrorbells
set visualbell

" Use modeline overrides
set modeline
set modelines=10

" Open splits below and right by default
set splitbelow
set splitright

" Performance optimizations
set ttyfast
set lazyredraw
syntax sync minlines=256

" Show 2 lines of context
set scrolloff=2

" don't delay when you hit esc in terminal vim, this may make arrow keys not
" work well when ssh'd in
set ttimeoutlen=5

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Persistent undo
set undofile
set undodir=~/.vim/undo

set undolevels=1000
set undoreload=10000

" clipboard
"set clipboard=unnamedplus
