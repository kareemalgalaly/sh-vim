" Vim filetype plugin
" Language: sh
" Maintainer: Kareem Ahmad

" let b:did_ftplugin if you want to disable the original/bundled plugin

if exists("b:did_ftplugin")
  finish
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Load bundled verilog defaults

source $VIMRUNTIME/ftplugin/sh.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Format options (see fo-table)
"   c = autowrap comments
"   r = (insert) enter continues comments
"   o = (normal) o , O continues comments

"set formatoptions-=ro " moved to vimrc

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
let s:arg = 'local opt OPTIND\n' .
          \ 'while getopts "\:" opt\n' .
          \ 'do\n' .
          \ '    case "$opt" in\n' .
          \ '        v ) ;;\n' .
          \ '    esac\n' .
          \ 'done\n'

let s:autocomplete_matches = [
 \      ['\v#( (.*))?'.s:eol                     , '\!## \2 \(repeat("-",61-col("."))\)'            ],
 \      ['\vdesc\s+(\w+)\s+(\w+)\s*(.*)$'        , '\!# \(repeat("-",51-col("."))\)\n# \1: \2\n# - \:\n# \(repeat("-",51-col("."))\)\n'],
 \      ['args'                                  , '\!'.s:arg                                       ],
 \      ['\vhead'                                , '\!'.s:hdr                                       ],
 \ ]
 "      ['\v(interface|module)\s+(\w+)'                 , '\N\:\nend\1}'              ],
 "      ['\v(interface|module)\s+(\w+)\s*(#\([^)]\))?'  , '\N\:\nend\1}'              ],

if exists('*autocomplete#register') | call autocomplete#register("sv", s:autocomplete_matches) | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Matching

if exists("loaded_matchit")
  let b:match_ignorecase=0
  let b:match_words=b:match_words.
    \ '\<class\>:\<endclass\>,'
    \ '\<program\>:\<endprogram\>,'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vexpand, vunexpand

function! sv#Vexpand(expand, file, bang)
    if (a:expand == 1)
        call system("vexpand " . a:file)
    else
        call system("vunexpand " . a:file)
    endif
    execute "edit" . a:bang . " " . file
endfunction

command! -bang Vexpand call sv#Vexpand(1, "%", "<bang>")
command! -bang Vunexpand call sv#Vexpand(0, "%", "<bang>")

