"===============================================================================
" Syntax: "{{{1

" Enable smart indent.
set autoindent
set smartindent

set synmaxcol=200

autocmd MyAutoCmd Syntax * if 10000 < line('$') | syntax sync minlines=100 | set foldmethod=indent | endif

" }}}1
"===============================================================================
" vim: foldmethod=marker
