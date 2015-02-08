" Operate on a block of text as if it were a given filetype
" Maintainer:	Barry Arthur <barry.arthur@gmail.com>
" Version:	0.1
" Description:	Asif lets you process a block of text as if it were inside a
"               vim buffer of a different filetype
" Last Change:	2013-06-01
" License:	Vim License (see :help license)
" Location:	plugin/asif.vim
" Website:	https://github.com/dahu/asif
"
" See asif.txt for help.  This can be accessed by doing:
"
" :helptags ~/.vim/doc
" :help asif

let g:asif_version = '0.1'

" Vimscript Setup: {{{1
" Allow use of line continuation.
let s:save_cpo = &cpo
set cpo&vim

"if exists("g:loaded_asif")
"      \ || v:version < 700
"      \ || v:version == 703 && !has('patch338')
"      \ || &compatible
"  let &cpo = s:save_cpo
"  finish
"endif
"let g:loaded_asif = 1

" Public Interface: {{{1
function! Asif(content, filetype, commands)
  let content = join(type(a:content) == type('')
        \ ? split(a:content, "\n")
        \ : a:content, ' ')

  call overlay#show(content, {}, {'filter': 0, 'use_split': 0})

  exe 'set filetype=' . a:filetype
  silent! $g/^$/d
  normal! 1G0
  for command in a:commands
    exe command
  endfor
  let result = getline(1,'$')

  call overlay#close()

  return result
endfunction

" Teardown:{{{1
"reset &cpo back to users setting
let &cpo = s:save_cpo

" vim: set sw=2 sts=2 et fdm=marker:
