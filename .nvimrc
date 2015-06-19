scriptencoding utf-8

if has('vim_starting')
  set nocompatible

  if !exists('$MYVIMRC')
    let $MYVIMRC = expand('~/.nvimrc')
  endif

  if !exists('$MYVIMFILES')
    let $MYVIMFILES = expand('~/.nvim')
  endif
endif

filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp
set fileformat=unix
set fileformats=unix,dos,mac

set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set smarttab
set expandtab
set autoindent
set smartindent

augroup KeywordPrgCmd
  autocmd!
  autocmd FileType vim         setlocal keywordprg=:help
  autocmd FileType sh,bash,zsh setlocal keywordprg=man\ -s
augroup END

set splitright
set splitbelow

set foldenable
set foldlevelstart=99
set foldcolumn=1
set foldmethod=syntax

augroup FoldAutoCmd
  autocmd!
  autocmd FileType yaml setlocal foldmethod=indent
  autocmd InsertEnter * if !exists('w:last_fdm')
        \| let w:last_fdm=&foldmethod
        \| setlocal foldmethod=manual
        \| endif
  autocmd InsertLeave,WinLeave * if exists('w:last_fdm')
        \| let &l:foldmethod=w:last_fdm
        \| unlet w:last_fdm
        \| endif
augroup END

set number
set numberwidth=4
set norelativenumber
set ruler

syntax enable

set modeline
set secure

" vim: ts=2 sts=2 sw=2 et
