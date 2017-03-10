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
  " echo tree.childlen[0].childlen[0].childlen[0].value
  echo s:ToString(tree, 0)
endfunction

function! s:ToString(node, d) abort
  for child in a:node.childlen
    if child.value ==# '0'
      return
    endif

    return child.value . ' > ' . s:ToString(child, a:d+1)
  endfor

  return 'EOL'
endfunction

" line: target string
" n: number of loop (first: 0)
function! s:Parse(line, n) abort
  let n = 0
  let prev = '>'
  let tree = {'parent': s:NIL, 'childlen': [], 'value': '.'}
  let parent = tree

  if strlen(a:line) == 0
    return tree
  endif

  "hoge>fuga>piyo
  "hoge+huge>fuga>piyo
  "div+div>p>span+em^bq+ql
  "div>(header>ul>li*2>a)+footer>p
  let word = ''
  for i in range(strlen(a:line))
    let c = nr2char(strgetchar(a:line, i))
    if c ==# ' '
      continue
    endif

    " 次に行う演算を保存しておく
    if c =~# '[+*^>]' || i + 1 == strlen(a:line)
      if i + 1 == strlen(a:line)
        let word = word . c
      endif

      if prev ==# '>'
        let node = {'parent': n, 'childlen': [], 'value': word}
        let parent.childlen = add(parent.childlen, node)
        let parent = node
        let n += 1
      elseif prev ==# '+'
        let node = {'parent': n, 'childlen': [], 'value': word}
        let parent.childlen = add(parent.childlen, node)
      endif

      let word = ''
    endif

    " if c ==# '+'
    "   let node = {'parent': n - 1, 'left': s:NIL, 'right': s:NIL, 'value': word}
    "   let tree = add(tree, node)
    "   let word = ''
    "   let i += 1
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
    " if c ==# '^'
    "   "div+div>p>span+em^bq の時、縦棒ほしい
    "   let space = s:Space(a:n-2)
    "   return evaled . "\n" . space . '+-- '. s:Parse(strcharpart(a:line, i+1), a:n-1)
    if c =~# '[+*^>]'
      let prev = c
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
