"===============================================================================
" Note: "{{{1
" .vimrc
"
" Auhtor: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

"===============================================================================
" Initialize: "{{{1

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

NeoBundle 'Shougo/unite.vim' " Unite and create user interfaces

NeoBundle 'altercation/vim-colors-solarized' " precision colorscheme for the vim text editor

NeoBundleCheck

filetype plugin indent on

" }}}1
"===============================================================================

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

set modeline

set list
set listchars=tab:>-,trail:_

set laststatus=2
set cmdheight=2
set showcmd

set wildmenu
set wildmode=list:longest,list
set wildoptions=tagfile

set background=dark
colorscheme solarized

"===============================================================================
" Plugins: "{{{1

"-------------------------------------------------------------------------------
" Unite: "{{{1

if neobundle#is_installed('unite.vim')

  nnoremap [unite] <nop>
  nmap <C-k> [unite]

  nnoremap [unite]   :<C-u>Unite<Space>
  nnoremap [unite]uf :<C-u>Unite -start-insert file<CR>

  if neobundle#is_installed('neobundle.vim')
    nnoremap [unite]n  :<C-u>Unite neobundle<CR>
    nnoremap [unite]ni :<C-u>Unite neobundle/install<CR>
    nnoremap [unite]na :<C-u>Unite neobundle/lazy<CR>
    nnoremap [unite]nl :<C-u>Unite neobundle/log<CR>
    nnoremap [unite]ns :<C-u>Unite neobundle/search<CR>
    nnoremap [unite]nu :<C-u>Unite neobundle/update<CR>
  endif
endif

" }}}1
"-------------------------------------------------------------------------------

" }}}1
"===============================================================================

" vim: foldmethod=marker foldlevel=0
