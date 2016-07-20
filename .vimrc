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

if my#iswin()
  language message en
else
  language message C
endif
language ctype C
language time C

let mapleader = ','
let maplocalleader = 'm'

nnoremap <LocalLeader> <Nop>
xnoremap <LocalLeader> <Nop>
nnoremap <leader> <Nop>
xnoremap <leader> <Nop>

" vim: foldmethod=marker
