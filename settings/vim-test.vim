nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

if has('nvim')
  let test#strategy = "neoterm"
  map <leader>/ :call neoterm#toggle()!<cr>
else
  let test#strategy = "dispatch"
  map <leader>/ :Copen!<cr>
end
