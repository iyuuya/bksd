"===============================================================================
" Note: "{{{1
" profiles/default/init.vim
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

if !exists('$XDG_CONFIG_HOME')
  let $XDG_CONFIG_HOME = expand('~/.config')
endif
if !exists('$XDG_CACHE_HOME')
  let $XDG_CACHE_HOME = expand('~/.cache')
endif
if !exists('$XDG_DATA_HOME')
  let $XDG_DATA_HOME = expand('~/.local/share')
endif
let $MYVIMFILES = expand($XDG_CONFIG_HOME . '/nvim')
execute 'set runtimepath^=' . $MYVIMFILES
let $MYVIMRC = expand($MYVIMFILES . '/init.vm')

language C

let g:nvim_config_path = expand($XDG_CONFIG_HOME . '/nvim')
let g:nvim_cache_path = expand($XDG_CACHE_HOME . '/nvim')
let g:nvim_data_path = expand($XDG_DATA_HOME . '/nvim')

call my#futil#mkdir_p(g:nvim_data_path . '/backup')
call my#futil#mkdir_p(g:nvim_data_path . '/swap')
call my#futil#mkdir_p(g:nvim_data_path . '/undo')

set backup
set nowritebackup
let &backupdir=g:nvim_data_path . '/backup'

set swapfile
let &directory=g:nvim_data_path . '/swap'

set undofile
let &undodir=g:nvim_data_path . '/undo'

call profile#source_profile_file('default', 'rc/encoding.vim')

augroup vim-local
  autocmd!
  autocmd VimEnter * call vim#local#load(expand('<afile>:p:h'))
augroup END

colorscheme iceberg

" vim: foldmethod=marker
