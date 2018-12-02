"===============================================================================
" Note: "{{{1
" autoload/my/rc.vim
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================
scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim

" source rc files from ~/.vim/rc/*.vim
function! my#rc#load()
  let filelist = split(glob('~/.vim/rc/*.vim'), "\n")
  for file in filelist
    execute 'source ' . file
  endfor
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
