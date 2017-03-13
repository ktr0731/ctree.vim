" File: autoload/ctree.vim
" Last Change: 2017 Mar 15
" Maintainer: Taro Aoki <aizu.s1230022@gmail.com>
" License: MIT license

let s:save_cpo = &cpo
set cpo&vim

let s:NIL = -1
let s:True = 1
let s:False = 0

function! ctree#Expand() range abort
  let tmp = @@
  silent normal gvy
  let selected = @@
  let @@ = tmp
  echo selected
endfunction

function! s:Parse(lines) abort
endfunction
