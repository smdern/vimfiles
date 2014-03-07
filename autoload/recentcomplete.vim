function! s:git_diff(args)
  return " git diff --diff-filter=AM --no-color ".a:args." 2>/dev/null | grep \\^+ 2>/dev/null | grep -v '+++ [ab]/' 2>/dev/null "
endfunction

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
  if !filereadable(expand('%'))
    return []
  endif
  let l:diff = system("echo ".shellescape(s:buffer_contents()).s:git_diff('--no-index -- '.expand('%').' -'))
  return s:extract_keywords_from_diff(l:diff)
endfunction

function! s:untracked_keywords()
  "echom 'git ls-files --others --exclude-standard 2>/dev/null | xargs -I % '.s:git_diff('git diff /dev/null %')
  " echom 'git ls-files --others --exclude-standard | xargs -I % '.s:git_diff('--no-index /dev/null %')
  let l:diff = system('git ls-files --others --exclude-standard | xargs -I % '.s:git_diff('--no-index /dev/null %'))
  "echom l:diff
  return s:extract_keywords_from_diff(l:diff)
endfunction

function! s:uncommitted_keywords()
  let l:diff = system(s:git_diff('HEAD'))
  return s:extract_keywords_from_diff(l:diff)
endfunction

let s:commit_cache = {}

function! s:recently_committed_keywords()
  let l:head = system("git rev-parse HEAD")
  if has_key(s:commit_cache, l:head)
    return s:commit_cache[l:head]
  endif

  " TODO: cache, maybe one commit at a time
  " To get commits:
  " git log --after="30 minutes ago" --format=%H
  " Then for each:
  " git show --pretty=format: --no-color <SHA>
  let l:diff = system(s:git_diff("@'{8.hours.ago}'"))
  let l:diff = join(reverse(split(l:diff, '\n')), "\n")
  let l:result = s:extract_keywords_from_diff(l:diff)
  let s:commit_cache[l:head] = l:result
  return l:result
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
