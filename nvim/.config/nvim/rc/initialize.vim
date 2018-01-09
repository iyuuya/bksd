"===============================================================================
" Initialize: "{{{1

"-------------------------------------------------------------------------------
" Initialize Options: "{{{2

" Enable no Vi compatible commands.
if &compatible && has('vim_starting')
  set nocompatible
endif

let g:python_host_prog = expand('~/.anyenv/envs/pyenv/versions/neovim2/bin/python')
let g:python3_host_prog = expand('~/.anyenv/envs/pyenv/versions/neovim3/bin/python')

let $MYVIMFILES = expand('~/.config/nvim')
execute 'set runtimepath^=' . $MYVIMFILES

if my#iswin()
  language message en
else
  language message C
endif
language ctype C
language time C

let g:mapleader = ','
let g:maplocalleader = 'm'

nnoremap <LocalLeader> <Nop>
xnoremap <LocalLeader> <Nop>
nnoremap <leader> <Nop>
xnoremap <leader> <Nop>

" tmp directory.
if !exists('g:vim_tmp_directory')
  let g:vim_tmp_directory = $MYVIMFILES . '/tmp'
endif

" Create tmp directory.
call my#mkdir_p(g:vim_tmp_directory)

" environment variables.
if !exists('$MYVIMRC')
  let $MYVIMRC = expand($MYVIMFILES . 'init.vm')
endif

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

  if dein#load_state(s:dein_dir)
    let s:toml      = expand($MYVIMFILES . '/toml/dein.toml')
    let s:lazy_toml = expand($MYVIMFILES . '/toml/dein_lazy.toml')
    call dein#begin(s:dein_dir)
    call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})
    call dein#end()
    call dein#save_state()
    unlet s:toml
    unlet s:lazy_toml
  endif

  if dein#check_install()
    call dein#install()
  endif

  unlet s:dein_dir
  unlet s:dein_repo_dir
endif

" }}}2
"-------------------------------------------------------------------------------

filetype indent plugin on

" }}}1
"===============================================================================
" vim: foldmethod=marker
