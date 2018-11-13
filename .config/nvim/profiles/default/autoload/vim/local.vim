"===============================================================================
" Note: "{{{1
" profiles/default/autoload/vim/local.vim
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim

function! vim#local#load(loc)
  let l:files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(l:files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
