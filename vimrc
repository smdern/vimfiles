"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Credits
" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
" https://github.com/nocash/vim-rc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('vim_starting')
 if &compatible
   set nocompatible
 endif

 set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

let mapleader = ","

" NeoBundle
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {
      \   'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'linux' : 'make',
      \     'unix' : 'gmake',
      \   }
      \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Include user's local vim bundles
" You can also override mapleader here
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vim_bundles.local"))
  source ~/.vim_bundles.local
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fugitive
"
" Git in vim, use ,gs for git status then - to stage then C to commit
" check :help Gstatus for more keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-fugitive'

map <leader>gs :Gstatus<cr>
map <leader>gc :Gcommit<cr>
map <leader>ga :Git add --all<cr>:Gcommit<cr>
map <leader>gb :Gblame<cr>

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

" Automatically remove fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Surrond stuff with things. ysiw" surrounds a word with quotes
" cs"' changes " to '
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-surround'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lets you use . to repeat some things like vim-surround
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-repeat'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" projectionist.vim
"
" Gives :A and :E* and such like rails.vim but for other languages/projects
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-projectionist'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Comment with gc (takes a motion) or ^_^_
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tomtom/tcomment_vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ctrl-P
"
" Open a file (like cmd-t but better). Use ,f or ,j(something, see bindings
" below)
"
" Includes a matcher written in c that is faster and more accurate, see:
" https://github.com/JazzCore/ctrlp-cmatcher
" It must be built, it requires python-dev as a dependency
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'JazzCore/ctrlp-cmatcher', {
      \   'build' : {
      \     'windows' : 'install_windows.bat',
      \     'mac' : './install.sh',
      \     'linux' : './install.sh',
      \     'unix' : './install.sh',
      \    }
      \  }

if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = {
        \   'types': {
        \     1: ['.git/', 'cd %s && git ls-files --cached --exclude-standard --others']
        \   },
        \   'fallback': 'cd %s && ag --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'
        \ }

  " ag is fast enough that CtrlP doesn't need to cache
  " no it isn't
  " let g:ctrlp_use_caching = 0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }

" Don't manage working directory
let g:ctrlp_working_path_mode = 0
let g:ctrlp_follow_symlinks = 2

map <leader>jv :let g:ctrlp_default_input = 'app/views/'<cr>:CtrlP<cr>
map <leader>jc :let g:ctrlp_default_input = 'app/controllers/'<cr>:CtrlP<cr>
map <leader>jm :let g:ctrlp_default_input = 'app/models/'<cr>:CtrlP<cr>
map <leader>jh :let g:ctrlp_default_input = 'app/helpers/'<cr>:CtrlP<cr>
map <leader>jl :let g:ctrlp_default_input = 'lib'<cr>:CtrlP<cr>
map <leader>jp :let g:ctrlp_default_input = 'public'<cr>:CtrlP<cr>
map <leader>js :let g:ctrlp_default_input = 'app/stylesheets/'<cr>:CtrlP<cr>
map <leader>jj :let g:ctrlp_default_input = 'app/javascripts/'<cr>:CtrlP<cr>
map <leader>jf :let g:ctrlp_default_input = 'features/'<cr>:CtrlP<cr>
map <leader>js :let g:ctrlp_default_input = 'spec/'<cr>:CtrlP<cr>
map <leader>ja :let g:ctrlp_default_input = 'spec/acceptance/'<cr>:CtrlP<cr>
map <leader>f :let g:ctrlp_default_input = 0<cr>:CtrlP<cr>
map <leader>u :let g:ctrlp_default_input = 0<cr>:CtrlPBuffer<cr>
map <leader>U :let g:ctrlp_default_input = 0<cr>:CtrlPLine<cr>
map <leader><leader>f :let g:ctrlp_default_input = 0<cr>:CtrlPClearCache<cr>:CtrlP<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ack/Ag
"
" Adds :Ack/:Ag complete w/ quick fix. I prefer to use :Ag! which does not open
" the first thing it finds automatically.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'mileszs/ack.vim'
NeoBundle 'rking/ag.vim'

map <leader>a :Ag!<space>
map <leader>A :Ag! <C-R><C-W><CR>

" Use ag for search, it's much faster than ack.
" See https://github.com/ggreer/the_silver_searcher
" on mac: brew install the_silver_searcher
let g:ag_prg = 'ag --nogroup --nocolor --column --smart-case'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Kills a buffer without closing a split, use ,w . Used in conjunction
" with command-w, below...
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'moll/vim-bbye'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command W
"
" Smarts around killing buffers, will close the split if it's the last buffer in
" it, and close vim if it's the last buffer/split. Use ,w
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'aaronjensen/vim-command-w'

nmap <leader>w :CommandW<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically add end at the end of ruby and vim blocks
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-endwise'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add a few paired mappings, in particular [q and ]q to navigate the quickfix
" list
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-unimpaired'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Handy file manipulations. Favorites are :Remove and :Rename
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-eunuch'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allows custom textobj motions (like i" or a[)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'kana/vim-textobj-user'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Motion based on indent level. Useful in coffeescript, try vai to select
" everything on the current indent level. vii is similar, but will not ignore
" blank lines
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'kana/vim-textobj-indent'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Motion based on ruby blocks. vir selects in a ruby block
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'nelstrom/vim-textobj-rubyblock'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vroom
"
" Run specs or cucumber features with ,t run only the test under the cursor
" with ,T also remembers last run test so you can hit it again on non-test
" files to run the last run test
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'skalnik/vim-vroom'
NeoBundle 'tpope/vim-dispatch'

let g:vroom_map_keys = 0
let g:vroom_write_all = 1
let g:vroom_use_zeus = 1
let g:vroom_use_bundle_exec = 0
let g:vroom_use_dispatch = 0

let g:dispatch_compilers = {
      \ 'bundle exec': '',
      \ 'clear;': '',
      \ 'zeus': ''}

let g:vroom_mix_test_command = 'MIX_ENV=test mix test '

map <leader>t :VroomRunTestFile<cr>
map <leader>T :VroomRunNearestTest<cr>
map <leader>/ :Copen!<cr>
map <silent> <leader>i :let g:vroom_use_dispatch = !g:vroom_use_dispatch<cr>
autocmd BufNewFile,BufRead *.spec.js map <buffer> <leader>t :w<cr>:!node_modules/.bin/mocha % -r specs/specHelper.js<cr>
autocmd BufNewFile,BufRead *_spec.coffee map <buffer> <leader>t :w<cr>:!zeus teaspoon %<cr>
autocmd BufNewFile,BufRead *_spec.js map <buffer> <leader>t :w<cr>:!zeus teaspoon %<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim coffeescript runtime files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'kchmck/vim-coffee-script'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Updated ruby syntax and such
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'vim-ruby/vim-ruby'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax highlighting for Gemfile
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-bundler'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Some syntax highlighthing for rails and :Rextract to extract partials
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-rails'

map <leader><leader>a :A<cr>
map <leader><leader>r :R<cr>
map <leader>va :AV<cr>
map <leader>vr :RV<cr>
map <leader>sa :AS<cr>
map <leader>sr :RS<cr>
" Make spec/test
map <leader>ms :exec ':Runittest '.expand("%:t:r").'!'<cr>

let g:rails_projections = {
  \"app/assets/javascripts/*.coffee": {
  \  "alternate": ["spec/javascripts/%s_spec.coffee"],
  \},
  \"spec/javascripts/*_spec.coffee": {
  \  "alternate": "app/assets/javascripts/%s.coffee",
  \},
\}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Improved javascript indentation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/pangloss/vim-javascript/pull/250
" NeoBundle 'pangloss/vim-javascript'
NeoBundle 'utix/vim-javascript', 'develop'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Git runtime files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-git'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim runtime files for Haml, Sass, and SCSS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-haml'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim syntax highlighting for less
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'groenewege/vim-less'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim runtime files for Slim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'slim-template/vim-slim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Markdown runtime files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-markdown'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim handlebars runtime files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'nono/vim-handlebars'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax for jquery keywords and selectors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'itspriddle/vim-jquery'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim syntax for jst files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'jeyb/vim-jst'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax for nginx
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'mutewinter/nginx.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Makes css colors show up as their actual colors, works better with CSApprox
" or macvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'ap/vim-css-color'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My favorite dark color scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tomasr/molokai'
let g:rehash256 = 1
let g:molokai_original = 1
set t_Co=256

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Decent light color scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'nelstrom/vim-mac-classic-theme'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" makes the command line and insert mode behave like emacs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-rsi'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Adds gr command to replace text (takes a motion)
" similar to v(motion)p but also cuts text into black hole register so it is
" repeatable. So really it's similar to v(motion)"_p
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'ReplaceWithRegister'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" xmpfilter
"
" Lets you execute ruby code in a buffer. Results will be output
" after any #=>. You can press F4 to insert a #=> on the current line and f5
" runs the entire buffer.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 't9md/vim-ruby-xmpfilter'

nmap <buffer> <F5> <Plug>(xmpfilter-run)
xmap <buffer> <F5> <Plug>(xmpfilter-run)
imap <buffer> <F5> <Plug>(xmpfilter-run)

nmap <buffer> <F4> <Plug>(xmpfilter-mark)
xmap <buffer> <F4> <Plug>(xmpfilter-mark)
imap <buffer> <F4> <Plug>(xmpfilter-mark)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" matchindent.vim
"
" Attempt to guess and automatically set the indentation settings of the
" opened file. Works for " 2 space, 4 space and tab indentation.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'conormcd/matchindent.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vitality.vim
"
" Add FocusGained/FocusLost back.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/sjl/vitality.vim/pull/23
NeoBundle 'aaronjensen/vitality.vim'
let g:vitality_fix_focus = 1
let g:vitality_fix_cursor = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-emblem
"
" Syntax highlighting for emblem
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'heartsentwined/vim-emblem'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rspec.vim
"
" Syntax highlighting for rspec in non-rails projects
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'Keithbsmiley/rspec.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-abolish
"
" Work with variants of a word: search/replace, abbreviations.
" Also adds coercion:
" crs snake_case
" crm MixedCase
" crc camelCase
" cru UPPER_CASE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-abolish'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-vinegar
"
" netrw fixes to make it better. Press - in normal mode.
" Use ,w to get back.
" Use cd to change your vim current directory.
" Use - to go up a directory.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-vinegar'
autocmd FileType netrw map <buffer> <leader>w :bwipeout<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-scriptease
"
" Lots of helpers for writing scripts.
" See :h scriptease
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-scriptease'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto completion
"
" Several plugins play nice to automatically pop up the autocomplete window if
" you want that, and let you use tab to cycle through options or restart
" completion.
"
" Settings are in plugin/mycomplete.vim
"
" neocomplete requires vim compiled w/ lua support.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'dirkwallenstein/vim-localcomplete'
NeoBundle 'aaronjensen/vim-recentcomplete'

NeoBundle 'Shougo/neocomplete.vim'

" make enter always be enter, even when popup menu is visible.
inoremap <CR> <C-g>u<C-r>=pumvisible()?"\C-y":""<CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets
"
" Hit ctrl-k to expand snippets and jump to next field
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'Shougo/neosnippet.vim'
" NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'honza/vim-snippets'
let g:neosnippet#disable_runtime_snippets = {'_': 1}
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
autocmd FileType * NeoSnippetMakeCache

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dockerfile.vim
"
" Syntax for Dockerfile
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'ekalinin/Dockerfile.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" sideways.vim
"
" Move parameters around with ,< and ,>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'AndrewRadev/sideways.vim'
nnoremap (( :SidewaysLeft<cr>
nnoremap )) :SidewaysRight<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dash.vim
"
" Look up words in dash
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'rizzatti/dash.vim'
nmap <silent> <leader>h <Plug>DashGlobalSearch
nmap <silent> <leader><leader>h <Plug>DashSearch

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-cjsx
"
" Support for coffee-react
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'mtscout6/vim-cjsx'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-jsx
"
" Support for react jsx
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'mxw/vim-jsx'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-auto-save
"
" Automatically save.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoBundle '907th/vim-auto-save'
" let g:auto_save = 1
" let g:auto_save_silent = 1
" let g:auto_save_in_insert_mode = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-jade
"
" Support for jade files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'digitaltoad/vim-jade'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-json
"
" Support for json files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-filetype-haskell
"
" Indentation for haskell files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'kana/vim-filetype-haskell'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tabular
"
" Align things with :Tab /whatever
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'godlygeek/tabular'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clojure stuff
"
" http://clojure-doc.org/articles/tutorials/vim_fireplace.html
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clojure REPL
"
" You'll want to install https://github.com/clojure-emacs/cider-nrepl
"
" cq - Clojure Quasi-REPL
" cqq - Populate REPL w/ current expression
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-fireplace'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leiningen stuff
"
" :Console
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'tpope/vim-leiningen'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" paredit.vim
"
" Structured editing of Lisp S-expressions
"
" ,< - slurp or barf to left
" ,> - slurp or barf to right
" ,J - Join
" ,O - Split (Open)
" ,W - Wrap with parens
" ,w[ - Wrap w/ brackets
" ,S - Splice (opposite of Wrap)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'paredit.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" words-to-avoid
"
" Highlights words like basically, just, so, etc in markdown files so I don't
" use them.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'nicholaides/words-to-avoid.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" splitjoin.vim
"
" Language aware split/join, for splitting things like postfix ifs
"
" gS - split a one-liner into multiple lines
" gJ - (with the cursor on the first line of a block) join a block into a single-line statement.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'AndrewRadev/splitjoin.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-yankstack
"
" lightweight implementation of the Emacs 'kill ring' for Vim. It allows you
" to yank and delete things without worrying about losing the text that you
" yanked previously.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'maxbrunsfeld/vim-yankstack'
let g:yankstack_map_keys = 0
nmap <m-p> <Plug>yankstack_substitute_older_paste
nmap <m-n> <Plug>yankstack_substitute_newer_paste

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-elixir
"
" Elixir runtime
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'elixir-lang/vim-elixir'

call neobundle#end()

:runtime macros/matchit.vim

filetype plugin indent on

NeoBundleCheck

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

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
set t_vb=

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
set undodir=$HOME/.vim/undo

set undolevels=1000
set undoreload=10000

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commonly changed settings, override in your vimrc.local
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:expandWindows = 1
let g:disableArrowKeys = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LAST SECTION
" Include user's local vim config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
