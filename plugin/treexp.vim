" File: treexp.vim
" Last Change: 2017 Mar 15
" Maintainer: Taro Aoki <aizu.s1230022@gmail.com>
" License: MIT license

if exists('g:loaded_treexp')
  finish
endif
let g:loaded_treexp = 1

let s:save_cpo = &cpo
set cpo&vim

let &cpo = s:save_cpo
unlet s:save_cpo
