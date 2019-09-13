scriptencoding utf-8

function! my#ft#vim#init()
  call my#ft#vim#detect()
endfunction

function! my#ft#vim#config()
  setlocal number
  setlocal tabstop=2
  setlocal softtabstop=2
  setlocal shiftwidth=2
  setlocal expandtab
endfunction

function! my#ft#vim#detect()
  augroup MyFtVimDetect
    autocmd!
    autocmd BufNewFile,BufRead *.vim call my#ft#vim#config()
  augroup END
endfunction
