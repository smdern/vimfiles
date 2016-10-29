autocmd FileType
      \ coffee,eruby,haml,javascript,php,ruby,sass,scss,sh,xml,elixir
      \ autocmd BufWritePre <buffer> StripWhitespace
