nmap <silent> <leader>T :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

if has('nvim')
  let test#strategy = "neoterm"
  map <leader>q :call neoterm#toggle()<CR>
else
  let test#strategy = "dispatch"
  map <leader>q :Copen!<cr>
end
