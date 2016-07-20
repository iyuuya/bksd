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

" tmp directory.
if !exists('g:vim_tmp_directory')
  let g:vim_tmp_directory = $MYVIMFILES . "/tmp"
endif

" Create tmp directory.
call my#mkdir_p(g:vim_tmp_directory)

filetype indent plugin on
syntax enable

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932
set fileformat=unix
set fileformats=unix,dos,mac

set ignorecase
set smartcase
set infercase
set incsearch
set hlsearch
set wrapscan

set number
set ruler

" vim: foldmethod=marker
