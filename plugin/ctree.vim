" File: plugin/ctree.vim
" Last Change: 2017 Mar 15
" Maintainer: Taro Aoki <aizu.s1230022@gmail.com>
" License: MIT license

" TODO: 後で外す
" if exists('g:loaded_treexp')
"   finish
" endif
" let g:loaded_treexp = 1

let s:save_cpo = &cpo
set cpo&vim

command! -range=% CTree call ctree#Expand()

let &cpo = s:save_cpo
unlet s:save_cpo
