" File: autoload/treexp.vim
" Last Change: 2017 Mar 15
" Maintainer: Taro Aoki <aizu.s1230022@gmail.com>
" License: MIT license

let s:save_cpo = &cpo
set cpo&vim

let s:NIL = -1

function! treexp#Expand() abort
  " call s:Parse(getline('.'), 0)
  let tree = s:Parse(getline('.'), 0)
  for item in tree
    echo item.value
  endfor
endfunction

" line: target string
" n: number of loop (first: 0)
function! s:Parse(line, n) abort
  " Use left-child, right-sibling representation
  let i = 1
  let tree = [{'parent': s:NIL, 'right': s:NIL, 'left': s:NIL, 'value': '.'}]

  if strlen(a:line) == 0
    return tree
  endif

  "hoge>fuga>piyo
  "hoge+huge>fuga>piyo
  "div+div>p>span+em^bq+ql
  "div>(header>ul>li*2>a)+footer>p
  let word = ''
  for k in range(strlen(a:line))
    let c = nr2char(strgetchar(a:line, k))
    if c ==# ' '
      continue
    endif

    " if c == '+'
    "   let sep = a:n == 0 ? '' : s:Space(a:n-1) . '+-- '
    "   return evaled . "\n" . sep . s:Parse(strcharpart(a:line, i+1), a:n)
    " elseif c == '*'
    "   " TODO
    "   " let num = str2nr(nr2char(strgetchar(a:line, i+1)))
    "   " let sep = a:n == 0 ? '' : s:Space(a:n-1) . '+-- '
    "   "
    "   " for j in range(num)
    "   "   " 取得する必要がある
    "   "   let evaled = evaled . "\n" . sep . s:Parse(strcharpart(a:line, i+2), a:n)
    "   " endfor
    "   " return evaled
    "   continue
    " elseif c == '^'
    "   "div+div>p>span+em^bq の時、縦棒ほしい
    "   let space = s:Space(a:n-2)
    "   return evaled . "\n" . space . '+-- '. s:Parse(strcharpart(a:line, i+1), a:n-1)
    " elseif c == '>'
    if c ==# '>'
      let node = {'parent': i - 1, 'left': s:NIL, 'right': s:NIL, 'value': word}
      let tree = add(tree, node)
      let word = ''
      let i += 1
    else
      let word = word . c
    endif
  endfor

  return tree
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
