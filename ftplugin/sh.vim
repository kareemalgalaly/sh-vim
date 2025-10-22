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
let s:com = '## ' . repeat("-", 60-3)
let s:hdr = '###############################################################################\n' .
          \ '# File        : \<%\>\n' .
          \ '# Author      : \<$USER\>\n' .
          \ '# Created     : \d\n' .
          \ '# Description : \n' .
          \ '###############################################################################\n\:\n'
let s:arg = 'local opt OPTIND\nwhile getopts "\:" opt\ndo\ncase "$opt" in\nv ) ;;\nesac\ndone\n'

let s:autocomplete_matches = [
 \      ['\v#( (.*))?'.s:eol                     , '\!## \2 \(repeat("-",61-col("."))\)'            ],
 \      ['\vdesc\s+(\w+)\s+(\w+)\s*(.*)$'        , '\!# \(repeat("-",51-col("."))\)\n# \1: \2\n# - \:\n# \(repeat("-",51-col("."))\)\n'],
 \      ['args'                                  , '\!'.s:arg                                       ],
 \      ['\vhead'                                , '\!'.s:hdr                                       ],
 \ ]
 "      ['\v(interface|module)\s+(\w+)'                 , '\N\:\nend\1}'              ],
 "      ['\v(interface|module)\s+(\w+)\s*(#\([^)]\))?'  , '\N\:\nend\1}'              ],

if exists('*autocomplete#register') | call autocomplete#register("sh", s:autocomplete_matches) | endif


