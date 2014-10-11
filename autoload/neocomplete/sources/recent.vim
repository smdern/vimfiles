let s:save_cpo = &cpo
set cpo&vim

let s:source = {
   \ 'name' : 'recent',
   \ 'kind' : 'keyword',
   \ 'mark' : '[R]',
   \ 'rank' : 20,
   \ 'min_pattern_length' : 1,
   \ 'max_candidates' : 20,
   \ 'is_volatile': 1,
   \ }

function! s:source.gather_candidates(context)
  let result = recentcomplete#matches(0, '')
  call map(result, "{ 'word': v:val.word, 'menu': '[R]' }")
  return result
endfunction

function! neocomplete#sources#recent#define()
  return s:source
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
