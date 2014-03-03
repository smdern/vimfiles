function mycomplete#CompleteCombinerRuby(findstart, keyword_base)
  let l:all_completers = [
        \ 'localcomplete#localMatches',
        \ 'localcomplete#allBufferMatches',
        \ 'rubycomplete#Complete',
        \ ]
  return combinerEXP#completeCombinerABSTRACT(
        \ a:findstart,
        \ a:keyword_base,
        \ l:all_completers,
        \ 2)
endfunction

function mycomplete#CompleteCombinerRubyKeywords(findstart, keyword_base)
  let l:all_completers = [
        \ 'localcomplete#localMatches',
        \ 'localcomplete#allBufferMatches',
        \ ]
  return combinerEXP#completeCombinerABSTRACT(
        \ a:findstart,
        \ a:keyword_base,
        \ l:all_completers,
        \ 0)
endfunction

function mycomplete#CompleteCombinerCss(findstart, keyword_base)
  let l:all_completers = [
        \ 'localcomplete#localMatches',
        \ 'localcomplete#allBufferMatches',
        \ ]
  return combinerEXP#completeCombinerABSTRACT(
        \ a:findstart,
        \ a:keyword_base,
        \ l:all_completers,
        \ 0)
endfunction

function mycomplete#MeetsForTags(context)
  if empty(tagfiles())
    return 0
  endif

  return acp#meetsForKeyword(a:context)
endfunction
