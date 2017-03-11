" File: autoload/treexp.vim
" Last Change: 2017 Mar 15
" Maintainer: Taro Aoki <aizu.s1230022@gmail.com>
" License: MIT license

let s:save_cpo = &cpo
set cpo&vim

let s:NIL = -1
let s:True = 1
let s:False = 0

function! treexp#Expand() abort
  " call s:Parse(getline('.'), 0)
  let tree = s:Parse('.>' . getline('.'), 0)
  " echo tree.childlen[0].childlen[0].childlen[0].value
endfunction

" line: target string
function! s:Parse(line, n) abort
  let prev = '>'
  let root = {'parent': s:NIL, 'left': s:NIL, 'right': s:NIL}

  let n = len(s:SplitBy(a:line, '+*^>', s:True))
  let T = []
  let value = []
  for k in range(n)
    let T = add(T, {'parent': s:NIL, 'left': s:NIL, 'right': s:NIL})
    let value = add(value, s:NIL)
  endfor

  "hoge>fuga>piyo
  "hoge+huge>fuga>piyo
  "div+div>p>span+em^bq+ql
  "div>(header>ul>li*2>a)+footer>p
  let i = 0
  let fragment = s:SplitBy(a:line, '>', s:True)
  let prevId = -1
  for degree in fragment
    let parsed = s:SplitBy(degree, '+*^', s:False)
    echo parsed

    if i ==# 0
      let parentId = s:NIL
    else
      let parentId = i - 1
    endif
    let j = 0
    for node in parsed
      if j ==# 0
        let T[parentId].left = i
      else
        let T[prevId].right = i
      endif

      let T[i].parent = parentId
      let prevId = i
      let i += 1
    endfor
  endfor
  echo T

  " for i in range(strlen(a:line))
  "   let c = nr2char(strgetchar(a:line, i))
  "   if c ==# ' '
  "     continue
  "   endif
  "
  "   " 次に行う演算を保存しておく
  "   if c =~# '[+*^>]' || i + 1 == strlen(a:line)
  "     if i + 1 == strlen(a:line)
  "       let word = word . c
  "     endif
  "
  "     if prev ==# '>'
  "       let node = {'parent': n, 'childlen': [], 'value': word}
  "       let parent.childlen = add(parent.childlen, node)
  "       let parent = node
  "       let n += 1
  "     elseif prev ==# '+'
  "       let node = {'parent': n, 'childlen': [], 'value': word}
  "       let parent.childlen = add(parent.childlen, node)
  "     endif
  "
  "     let word = ''
  "   endif
  "
  "   if c =~# '[+*^>]'
  "     let prev = c
  "   else
  "     let word = word . c
  "   endif
  " endfor

  " return tree
endfunction

function! s:SplitBy(line, pattern, omitOpes) abort
  let splitted = []
  let text = ''

  for i in range(strlen(a:line))
    let c = nr2char(strgetchar(a:line, i))
    if c ==# ' '
      continue
    endif

    if c =~# '[' . a:pattern . ']'
      let splitted = add(splitted, text)
      if a:omitOpes ==# s:False
        let splitted = add(splitted, c)
      endif
      let text = ''
    else
      let text = text . c
    endif
  endfor

  let splitted = add(splitted, text)

  return splitted
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
