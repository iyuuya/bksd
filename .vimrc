
if has('vim_starting')
  set nocompatible
endif

if !exists('$MYVIMRC')
  let $MYVIMRC = expand('~/.vimrc')
endif

if !exists('$MYGVIMRC')
  let $MYGVIMRC = expand('~/.gvimrc')
endif

if !exists('$MYVIMFILES')
  let $MYVIMFILES = expand('~/.vim')
endif

filetype plugin indent on

syntax enable

set nu
set ts=2
set sts=2
set sw=2
set et
