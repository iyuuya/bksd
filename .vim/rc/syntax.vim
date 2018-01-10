"===============================================================================
" Syntax: "{{{1

" Enable smart indent.
set autoindent
set smartindent

set synmaxcol=200

autocmd MyAutoCmd Syntax * if 10000 < line('$') | syntax sync minlines=100 | set foldmethod=indent | endif
autocmd MyAutoCmd VimEnter,ColorScheme * call <SID>AfterColors()

function! <SID>AfterColors()
  if exists('g:colors_name') && strlen(g:colors_name)
    execute 'runtime! after/colors/' . g:colors_name . '.vim'
  endif
endfunction

" }}}1
"===============================================================================
" vim: foldmethod=marker
