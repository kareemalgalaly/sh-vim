" Vim filetype plugin
" Language: sh
" Maintainer: Kareem Ahmad

" let b:did_ftplugin if you want to disable the original/bundled plugin

if exists("b:did_ftplugin")
  finish
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load bundled defaults

source $VIMRUNTIME/ftplugin/sh.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup Expressions for Autocomplete plugin

let s:sol = '^\s*'
let s:eol = '\s*(//.*)?$'
let s:arg = 'local opt OPTIND\n' .
          \ 'while getopts "h" opt\n' .
          \ 'do\ncase "$opt" in\n' .
          \ 'h ) echo "Usage: \:"; return 1 ;;\nesac\ndone\n' .
          \ 'shift $((OPTIND - 1))\n'

let s:autocomplete_matches = [
 \      ['\vargs'.s:eol,  '\!'.s:arg  ],
 \ ] + autocomplete#common("#")

if exists('*autocomplete#register') | call autocomplete#register("sh", s:autocomplete_matches) | endif

