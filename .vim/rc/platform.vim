"===============================================================================
" Platform: "{{{1

if my#iswin()
  set shell=bash
else
  set shell=zsh
endif

if filereadable($HOME.'/.vimrc.local')
  source $HOME/.vimrc.local
endif

" }}}1
"===============================================================================
" vim: foldmethod=marker
