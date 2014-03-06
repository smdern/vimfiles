let s:git_diff = 'git diff --diff-filter=AM --no-color '
let s:grep_add = '|grep ^+'

function! s:buffer_contents()
  if &fileformat ==# "dos"
    let eol = "\r\n"
  elseif &fileformat ==# "mac"
    let eol = "\r"
  else
    let eol = "\n"
  endif
  return join(getbufline(bufname('%'), 1, '$'), eol) . eol
endfunction

function! s:find_start()
  let l:line = getline('.')
  let l:start = col('.') - 1

  while l:start > 0 && l:line[l:start - 1] =~ '\k'
    let l:start -= 1
  endwhile

  return l:start
endfunction

function! s:extract_keywords_from_diff(diff)
  let l:lines = filter(split(a:diff, "\n"), 'v:val =~# ''^+\(++ [ab]\)\@!''')
  let l:lines = map(l:lines, 'strpart(v:val, 1)')

  return split(substitute(join(l:lines), '\k\@!.', ' ', 'g'))
endfunction

function! s:buffer_keywords()
  let l:diff = system('git diff --no-index -- '.expand('%').' -', s:buffer_contents())
  return s:extract_keywords_from_diff(l:diff)
endfunction

function! s:untracked_keywords()
  let l:diff = system('git ls-files --others --exclude-standard | xargs -I % git diff /dev/null %')
  return s:extract_keywords_from_diff(l:diff)
endfunction

function! s:uncommitted_keywords()
  let l:diff = system(s:git_diff . 'HEAD' . s:grep_add)
  return s:extract_keywords_from_diff(l:diff)
endfunction

function! s:recently_committed_keywords()
  " TODO: cache, maybe one commit at a time
  " To get commits:
  " git log --after="30 minutes ago" --format=%H
  " Then for each:
  " git show --pretty=format: --no-color <SHA>
  let l:diff = system(s:git_diff . "@'{2.hours.ago}'". s:grep_add)
  let l:diff = join(reverse(split(l:diff, '\n')), "\n")
  return s:extract_keywords_from_diff(l:diff)
endfunction

function! s:matches(keyword_base)
  let l:keywords = s:buffer_keywords()
  let l:keywords += s:untracked_keywords()
  let l:keywords += s:uncommitted_keywords()
  let l:keywords += s:recently_committed_keywords()

  let l:base = escape(a:keyword_base, '\\/.*$^~[]')
  return filter(l:keywords, "v:val =~# '^".l:base."'")
endfunction

function! recentcomplete#matches(find_start, keyword_base)
  if a:find_start
    return s:find_start()
  else
    return s:matches(a:keyword_base)
  endif
endfunction
