"===============================================================================
" Note: "{{{1
" .vimrc
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

"===============================================================================
" Initialize: "{{{1

"-------------------------------------------------------------------------------
" Initialize Options: "{{{2

" Enable no Vi compatible commands.
set nocompatible

" Check platform "{{{3
let s:iswin = has('win32') || has('win64') || has('win95') || has('win16')
let s:iscygwin = has('win32unix')
let s:ismac = has('mac') || has('macunix') || has('gui_mac') || has('gui_macvim') ||
      \ (!executable('xdg-open') && system('uname') =~? '^darwin')
let s:islinux = !s:iswin && !s:iscygwin && !s:ismac

if s:iswin
  language message en
else
  language message C
endif
language ctype C
language time C

let mapleader = ','
let maplocalleader = 'm'

nnoremap m <Nop>
xnoremap m <Nop>
nnoremap , <Nop>
xnoremap , <Nop>

if s:iswin
  set shellslash
endif

" environment variables.
if !exists("$MYVIMRC")
  let $MYVIMRC = expand('~/.vimrc')
endif

if !exists("$MYGVIMRC")
  let $MYGVIMRC = expand('~/.gvimrc')
endif

if !exists("$MYVIMFILES")
  if s:iswin
    let $MYVIMFILES = expand('~/vimfiles')
  else
    let $MYVIMFILES = expand('~/.vim')
  endif
endif

augroup MyAutoCmd
  autocmd!
augroup END

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" NeoBundle: "{{{2

if has('vim_starting')
  set runtimepath+=$MYVIMFILES/bundle/neobundle.vim
endif

if globpath(&rtp, 'bundle/neobundle.vim') != ''
  filetype off
  call neobundle#rc('$MYVIMFILES/bundle/')

  " Ultimate Vim package manager
  NeoBundleFetch 'Shougo/neobundle.vim'

  " Interactive command execution in Vim.
  NeoBundle 'Shougo/vimproc', {
        \ 'build' : {
        \   'win64' : 'nmake -f make_msvc32.mak',
        \   'win32' : 'nmake -f make_msvc64.mak',
        \   'mac'   : 'make -f make_mac.mak',
        \   'unix'  : 'make -f make_unix.mak',
        \   },
        \ }
endif


" }}}2
"-------------------------------------------------------------------------------

filetype indent on
filetype plugin on

" }}}1
"===============================================================================

" vim: foldmethod=marker
