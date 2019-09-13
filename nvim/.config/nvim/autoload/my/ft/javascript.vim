scriptencoding utf-8

function! my#ft#javascript#init()
  if executable('nodenv')
    let s:has_nodenv = 1
  else
    let s:has_nodenv = 0
  end

  call my#ft#javascript#detect()
endfunction

function! my#ft#javascript#config()
  setlocal number
  setlocal tabstop=2
  setlocal softtabstop=2
  setlocal shiftwidth=2
  setlocal expandtab
endfunction

function! my#ft#javascript#detect()
  augroup MyFtDetect
    autocmd!
    autocmd BufNewFile,BufRead *.js call my#ft#javascript#config()
  augroup END
endfunction

function! my#ft#javascript#has_nodenv()
  return s:has_nodenv
endfunction
