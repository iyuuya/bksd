"===============================================================================
" Initialize: "{{{1

"-------------------------------------------------------------------------------
" Initialize Options: "{{{2

if exists('$SUDO_USER')
  finish
endif

" Enable no Vi compatible commands.
if &compatible && has('vim_starting')
  set nocompatible
endif

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

" environment variables.
if !exists("$MYVIMRC")
  let $MYVIMRC = expand('~/.vimrc')
endif

if !exists("$MYGVIMRC")
  let $MYGVIMRC = expand('~/.gvimrc')
endif

if !exists("$MYVIMFILES")
  if my#iswin()
    let $MYVIMFILES = expand('~/vimfiles')
  else
    let $MYVIMFILES = expand('~/.vim')
  endif
endif

" tmp directory.
if !exists('g:vim_tmp_directory')
  let g:vim_tmp_directory = $HOME."/.vim/tmp"
endif

" Create tmp directory.
call my#mkdir_p(g:vim_tmp_directory)

augroup MyAutoCmd
  autocmd!
augroup END

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Dein: "{{{2
if has('vim_starting')
  let s:dein_dir = expand(g:vim_tmp_directory . '/dein')
  let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

  if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
  endif

  call dein#begin(s:dein_dir)

  let s:toml      = '~/.vim/rc/dein.toml'
  let s:lazy_toml = '~/.vim/rc/dein_lazy.toml'

  if dein#load_cache([expand('<sfile>'), s:toml, s:lazy_toml])
    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})
    call dein#save_cache()
  endif

  call dein#end()

  if dein#check_install()
    call dein#install()
  endif

  unlet s:dein_dir
  unlet s:dein_repo_dir
  unlet s:toml
  unlet s:lazy_toml
endif

" }}}2
"-------------------------------------------------------------------------------

filetype indent plugin on

" }}}1
"===============================================================================
" vim: foldmethod=marker
