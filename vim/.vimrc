"===============================================================================
" Note: "{{{1
" .vimrc
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

if exists('$SUDO_USER')
  finish
endif

if has('vim_starting') && &compatible
  set nocompatible
endif

let $MYVIMFILES = expand('~/.config/vim')
execute 'set runtimepath^=' . $MYVIMFILES

if my#iswin()
  language message en
else
  language message C
endif
language ctype C
language time C

let mapleader = ','
let maplocalleader = 'm'

nnoremap <LocalLeader> <Nop>
xnoremap <LocalLeader> <Nop>
nnoremap <leader> <Nop>
xnoremap <leader> <Nop>

" tmp directory.
if !exists('g:vim_tmp_directory')
  let g:vim_tmp_directory = $MYVIMFILES . "/tmp"
endif

" Create tmp directory.
call my#mkdir_p(g:vim_tmp_directory)

filetype indent plugin on
syntax enable

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932
set fileformat=unix
set fileformats=unix,dos,mac

"===============================================================================
" Search: "{{{1

set ignorecase
set smartcase
set infercase
set incsearch
set hlsearch
set wrapscan

if has('migemo')
  set migemo
endif

" }}}1
"===============================================================================

"===============================================================================
" Edit: "{{{1

call my#mkdir_p(g:vim_tmp_directory.'/backup')
call my#mkdir_p(g:vim_tmp_directory.'/swap')
call my#mkdir_p(g:vim_tmp_directory.'/undo')

set backup
set nowritebackup
let &backupdir=g:vim_tmp_directory.'/backup'
set swapfile
let &directory=g:vim_tmp_directory.'/swap'
set undofile
let &undodir=g:vim_tmp_directory.'/undo'

set updatetime=200

set timeout
set timeoutlen=750
set ttimeoutlen=200

set backspace=indent,eol,start

set clipboard&
set clipboard+=unnamed
if has('gui')
  set clipboard+=autoselect
endif

set autoread

set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround

set smarttab
set expandtab

set modeline

set foldenable
set foldlevelstart=99
set foldcolumn=1
set foldmethod=syntax

augroup FoldAutoGroup
  autocmd!
  autocmd FileType html,erb,haml,yaml setlocal foldmethod=indent
  autocmd InsertEnter * if !exists('w:last_fdm')
        \| let w:last_fdm=&foldmethod
        \| setlocal foldmethod=manual
        \| endif
  autocmd InsertLeave,WinLeave * if exists('w:last_fdm')
        \| let &l:foldmethod=w:last_fdm
        \| unlet w:last_fdm
        \| endif
augroup END

if executable('ag')
  set grepprg=ag\ --nogroup\ -iS
  set grepformat=%f:%l:%m
elseif executable('grep')
  set grepprg=grep\ -Hnd\ skip\ -r
  set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
else
  set grepprg=internal
endif

augroup VimGrepAutoCmd
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

" Set tags file.
set tags=./tags,tags

if v:version < 7.3 || (v:version == 7.3 && has('patch336'))
  " Vim's bug.
  set notagbsearch
endif

" Enable virtualedit in visual block mode.
set virtualedit=block

" Set keyword help. (K)
set keywordprg=:help
" default: set keywordprg=man\ -s
" will use unite.vim or ref.vim if can

" Increase history amount.
set history=10000

" }}}1
"===============================================================================

set number
set ruler

nnoremap <Space> :

" vim: foldmethod=marker tabstop=2 softtabstop=2 shiftwidth=2 expandtab
