" File: autoload/treexp.vim
" Last Change: 2017 Mar 15
" Maintainer: Taro Aoki <aizu.s1230022@gmail.com>
" License: MIT license

let s:save_cpo = &cpo
set cpo&vim

function! treexp#Expand() abort
  echo s:Parse(getline('.'))
endfunction

function! s:Parse(line) abort
  let splitted = split(a:line, '>')
  let tree = splitted[0]

  for word in splitted[1:]
    let tree = tree . "\n└─" . word
  endfor

  return tree
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
