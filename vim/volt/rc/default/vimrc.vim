"===============================================================================
" Note: "{{{1
" default: vimrc.vim
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

set encoding=utf-8
scriptencoding utf-8

if exists('$SUDO_USER')
  finish
endif

call my#rc#load()
