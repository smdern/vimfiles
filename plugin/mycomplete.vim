"let g:rubycomplete_buffer_loading = 1
set complete-=i

let g:localcomplete#OriginNoteLocalcomplete = '%'
let g:localcomplete#OriginNoteAllBuffers = '+'
let g:localcomplete#OriginNoteDictionary = '*'
let g:localcomplete#LocalMinPrefixLength = 0
let g:localcomplete#AllBuffersMinPrefixLength = 0

" Add $ and - as keyword chars in sass/css/haml as necessary
" $ doesn't work w/ localcomplete
autocmd BufRead,BufNewFile *.{sass,scss} setlocal iskeyword+=$
autocmd BufRead,BufNewFile *.{css,sass,scss,less,styl,haml,html,erb} setlocal iskeyword+=- 
  \| let b:LocalCompleteAdditionalKeywordChars = '-'

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#auto_completion_start_length = 1
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#enable_fuzzy_completion = 1
let g:neocomplete#enable_auto_delimiter = 0
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" It gets 100ms, then we skip it
let g:neocomplete#skip_auto_completion_time = 0.1

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

call neocomplete#custom#source('tag',
  \ 'disabled_filetypes', {'_' : 1})
call neocomplete#custom#source('omni', 'rank', 14)
call neocomplete#custom#source('omni', 'max_candidates', 20)
call neocomplete#custom#source('vim', 'rank', 15)
call neocomplete#custom#source('vim', 'max_candidates', 20)

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.css = '^\s\+\k\+\|\w\+[):;]\?\s\+\k*\|[@!]'
let g:neocomplete#sources#omni#input_patterns.clojure = '[[:alnum:]_-]\+'
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
