let s:save_cpo = &cpo
set cpo&vim

let s:source = {
   \ 'name' : 'local',
   \ 'kind' : 'keyword',
   \ 'mark' : '[L]',
   \ 'rank' : 19,
   \ 'min_pattern_length' : 1,
   \ 'max_candidates' : 20,
   \ 'is_volatile': 1,
   \ }

function! s:source.gather_candidates(context)
  let result = localcomplete#localMatches(0, a:context.complete_str[0])
    \ + localcomplete#allBufferMatches(0, a:context.complete_str[0])
  call map(result, "{ 'word': v:val.word, 'menu': '[L]' }")
  return result
endfunction

function! neocomplete#sources#local#define()
  return s:source
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
