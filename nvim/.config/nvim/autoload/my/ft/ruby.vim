scriptencoding utf-8

function! my#ft#ruby#init()
  if executable('rbenv')
    let s:has_rbenv = 1
  else
    let s:has_rbenv = 0
  end

  call my#ft#ruby#detect()
endfunction

function! my#ft#ruby#config()
  setlocal number
  setlocal tabstop=2
  setlocal softtabstop=2
  setlocal shiftwidth=2
  setlocal expandtab
endfunction

function! my#ft#ruby#detect()
  augroup MyFtDetect
    autocmd!
    autocmd BufNewFile,BufRead *.rb call my#ft#ruby#config()
    autocmd BufNewFile,BufRead *.rake call my#ft#ruby#config()
    autocmd BufNewFile,BufRead Gemfile call my#ft#ruby#config()
    autocmd BufNewFile,BufRead Rakefile call my#ft#ruby#config()
  augroup END
endfunction

function! my#ft#ruby#has_rbenv()
  return s:has_rbenv
endfunction
