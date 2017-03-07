" File: autoload/treexp.vim
" Last Change: 2017 Mar 15
" Maintainer: Taro Aoki <aizu.s1230022@gmail.com>
" License: MIT license

let s:save_cpo = &cpo
set cpo&vim

function! treexp#Expand() abort
  " call s:Parse(getline('.'), 0)
  echo s:Parse(getline('.'), 0)
endfunction

" line: target string
" n: number of loop (first: 0)
function! s:Parse(line, n) abort
  let splitted = split(a:line, '>')
  let tree = splitted[0]

  let evaled = ''

  if strlen(a:line) == 0
    return
  endif

  " hoge>fuga>piyo
  for i in range(strlen(a:line))
    let c = nr2char(strgetchar(a:line, i))
    if c == ' '
      continue
    endif

    if c == '>'
      let space = s:Space(a:n)
      return evaled . "\n" . space . '+-- '. s:Parse(strcharpart(a:line, i+1), a:n+1)
    else
      let evaled = evaled . c
    endif
  endfor

  return evaled
endfunction

function! s:Space(n) abort
  let space = '  '
  for j in range(a:n)
    let space = space . '  '
  endfor
  return space
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
