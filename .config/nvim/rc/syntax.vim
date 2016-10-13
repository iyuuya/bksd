"===============================================================================
" Syntax: "{{{1

" Enable smart indent.
set autoindent
set smartindent

set synmaxcol=200
autocmd Syntax * if 10000 < line('$') | syntax sync minlines=100 | endif

augroup MyArbGrp
  autocmd!
  autocmd BufRead,BufNew *.arb setlocal filetype=ruby
  autocmd BufRead,BufNew *.apib setlocal filetype=apiblueprint
  autocmd BufRead,BufNew *.ts setlocal filetype=typescript
  autocmd BufRead,BufNew *.vue setlocal filetype=html
augroup END

" }}}1
"===============================================================================
" vim: foldmethod=marker
