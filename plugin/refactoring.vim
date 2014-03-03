command! PromoteToLet call refactoring#PromoteToLet()
map <leader>l :PromoteToLet<cr>

command! PasteExtractedFunction call PasteExtractedFunction()
map <leader>mp :PasteExtractedFunction<cr>
