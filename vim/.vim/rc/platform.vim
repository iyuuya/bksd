"===============================================================================
" Platform: "{{{1

if my#iswin()
  set shell=bash
else
  if &shell =~# 'fish$'
    set shell=sh
  else
    set shell=zsh
  endif
endif

" }}}1
"===============================================================================
" vim: foldmethod=marker
