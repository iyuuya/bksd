scriptencoding utf-8

if has('vim_starting')
  set nocompatible

  if !exists('$MYVIMRC')
    let $MYVIMRC = expand('~/.nvimrc')
  endif

  if !exists('$MYVIMFILES')
    let $MYVIMFILES = expand('~/.nvimr')
  endif
endif

augroup MyAutoCmd
  autocmd!
augroup END

filetype plugin indent on

set number
set ruler

augroup MyAutoCmd
  autocmd FileType vim         setlocal keywordprg=:help
  autocmd FileType sh,bash,zsh setlocal keywordprg=man\ -s
augroup END

set splitright
set splitbelow

syntax enable

set modeline
set secure

" vim: ts=2 sts=2 sw=2 et
