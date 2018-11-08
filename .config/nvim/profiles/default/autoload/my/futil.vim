"===============================================================================
" Note: "{{{1
" profiles/default/autoload/my/futil.vim
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim

function! my#futil#mkdir_p(path)
  if !isdirectory(a:path)
    call mkdir(a:path, 'p')
  endif
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
