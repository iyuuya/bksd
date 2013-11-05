"===============================================================================

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

set ignorecase
set smartcase
set infercase
set incsearch
set hlsearch
set wrapscan

set number
set ruler

set backspace=indent,eol,start
set autoindent
set smartindent

set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set smarttab
set expandtab

set foldenable
set foldmethod=syntax
set foldlevelstart=99
set foldcolumn=1

set list
set listchars=tab:>-,trail:_

