scriptencoding utf-8

function! my#util#dir#mkdir_p(path)
  if !isdirectory(a:path)
    call mkdir(a:path, 'p')
  endif
endfunction
