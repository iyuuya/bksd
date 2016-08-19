"===============================================================================
" Syntax: "{{{1

" Enable smart indent.
set autoindent
set smartindent

augroup MyArbGrp
  autocmd!
  autocmd BufEnter,BufRead,BufNew *.arb setlocal filetype=ruby
  autocmd BufEnter,BufRead,BufNew *.apib setlocal filetype=apiblueprint
  autocmd BufEnter,BufRead,BufNEw *.ts setlocal filetype=typescript
augroup END

" }}}1
"===============================================================================
" vim: foldmethod=marker
