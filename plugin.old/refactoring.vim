command! PromoteToLet call refactoring#PromoteToLet()
map <leader>l :PromoteToLet<cr>

command! PasteExtractedFunction call refactoring#PasteExtractedFunction()
map <leader>mp :PasteExtractedFunction<cr>
