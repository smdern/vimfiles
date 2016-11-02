" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set ruler                       "Show line and col numbers
if has('vim_starting')
  set encoding=utf-8
end
set switchbuf=useopen

" Use bash because it's fast, zsh loads too slow w/ rvm
let $BASH_ENV = "~/.bash/env"
set shell=bash

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all 
" the plugins.
let mapleader=","

" =============== Plugin Initialization ===============
" This loads all the plugins specified in ~/.vim/plugins.vim
if filereadable(expand("~/.vim/plugins.vim"))
  source ~/.vim/plugins.vim
endif

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb
set nowritebackup
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
set undofile
set undodir=~/.vim/undo

set undolevels=1000
set undoreload=10000

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
" Whitespace and Wrapping
"                 +-> Auto-wrap comments using textwidth
"                 |+-> Allow formatting of comments with 'gq'
"                 ||+-> Automatically insert the current comment leader after
"                 |||   hitting Enter in Insert mode
"                 |||+-> Remove comment leaders when joining lines
set formatoptions=cqrj

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,public/javascripts/compiled
set wildignore+=tmp,*.orig,*.jpg,*.png,*.gif,log,solr,.sass-cache,.jhw-cache
set wildignore+=bundler_stubs,build,error_pages,bundle,build,error_pages

" ================ Scrolling ========================

set scrolloff=2  "Start scrolling when we're 2 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Status bar ===========================

set laststatus=2

" ================ Performance Optimizations ===========================

set ttyfast
set lazyredraw
syntax sync minlines=256
set ttimeoutlen=5  " Don't delay when you hit esc in terminal vim

" ================ Misc ===========================

" Use modeline overrides
set modeline
set modelines=10

" Open splits below and right by default
set splitbelow
set splitright

" ================ Custom Settings ========================
so ~/.vim/settings.vim

" =================== Color =========================

color molokai
