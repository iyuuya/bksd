"===============================================================================
" Note: "{{{1
" autoload/my.vim
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================
scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim

let s:iswin = has('win32') || has('win64') || has('win95') || has('win16')
let s:iscygwin = has('win32unix')
let s:ismac = has('mac') || has('macunix') || has('gui_mac') || has('gui_macvim') ||
      \ (!executable('xdg-open') && system('uname') =~? '^darwin')
let s:islinux = !s:iswin && !s:iscygwin && !s:ismac

function! my#iswin()
  return s:iswin
endfunction

function! my#iscygwin()
  return s:iscygwin
endfunction

function! my#ismac()
  return s:ismac
endfunction

function! my#islinux()
  return s:islinux
endfunction

function! my#mkdir_p(path)
  if !isdirectory(a:path)
    call mkdir(a:path, 'p')
  endif
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
