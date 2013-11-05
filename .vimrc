
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

if has('vim_starting')
  filetype off
  let bundle_path = $MYVIMFILES . '/bundle'
  let neobundle_path = bundle_path . '/neobundle.vim'
  execute 'set runtimepath+=' . neobundle_path

  if !isdirectory(neobundle_path)
    call system('git clone https://github.com/Shougo/neobundle.vim.git ' . neobundle_path)
  endif

  call neobundle#rc(bundle_path)
endif

NeoBundleFetch 'Shougo/neobundle.vim' " Ultimate Vim package manager

NeoBundleCheck

filetype plugin indent on

syntax enable

set nu
set ts=2
set sts=2
set sw=2
set et
