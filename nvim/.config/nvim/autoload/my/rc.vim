scriptencoding utf-8

function my#rc#local()
  let s:vimrc = getcwd() . '/.vimrc.local'
  if filereadable(s:vimrc)
    execute 'source ' . s:vimrc
  endif
endfunction
