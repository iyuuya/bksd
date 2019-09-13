scriptencoding utf-8

let s:is_win = has('win64') || has('win32') || has('win95') || has('win16')
let s:is_cygwin = has('win32unix')
let s:is_mac = has('mac') || has('macunix') || has('gui_mac') || has('gui_macvim') ||
      \ (!executable('xdg-open') && system('uname') =~? '^darwin')
let s:is_linux = !s:is_win && !s:is_cygwin && !s:is_mac

function! my#util#platform#is_win()
  return s:is_win
endfunction

function! my#util#platform#is_cygwin()
  return s:is_cygwin
endfunction

function! my#util#platform#is_mac()
  return s:is_mac
endfunction

function! my#util#platform#is_linux()
  return s:is_linux
endfunction
