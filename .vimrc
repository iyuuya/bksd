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

let $MYVIMFILES = expand('~/.config/vim')
execute 'set runtimepath^=' . $MYVIMFILES

" vim: foldmethod=marker
