"===============================================================================
" Note: "{{{1
" .vimrc
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

if exists('$SUDO_USER')
  finish
endif

if has('vim_starting') && &compatible
  set nocompatible
endif

" vim: foldmethod=marker
