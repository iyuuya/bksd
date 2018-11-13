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

augroup MyAutoCmd
  autocmd!
augroup END

call profile#source_profile_file('default', 'rc/1_important.vim')
call profile#source_profile_file('default', 'rc/2_moving_around_searching_and_patterns.vim')
call profile#source_profile_file('default', 'rc/3_tags.vim')
call profile#source_profile_file('default', 'rc/4_displaying_text.vim')
call profile#source_profile_file('default', 'rc/5_syntax_highlighting_and_spelling.vim')
call profile#source_profile_file('default', 'rc/6_multiple_windows.vim')
call profile#source_profile_file('default', 'rc/7_multiple_tab_pages.vim')
call profile#source_profile_file('default', 'rc/8_terminal.vim')
call profile#source_profile_file('default', 'rc/9_using_the_mouse.vim')
call profile#source_profile_file('default', 'rc/10_printing.vim')
call profile#source_profile_file('default', 'rc/11_messages_and_info.vim')
call profile#source_profile_file('default', 'rc/12_selecting_text.vim')
call profile#source_profile_file('default', 'rc/13_editing_text.vim')
call profile#source_profile_file('default', 'rc/14_tabs_and_indenting.vim')
call profile#source_profile_file('default', 'rc/15_folding.vim')
call profile#source_profile_file('default', 'rc/16_diff_mode.vim')
call profile#source_profile_file('default', 'rc/17_mapping.vim')
call profile#source_profile_file('default', 'rc/18_reading_and_writing_files.vim')
call profile#source_profile_file('default', 'rc/19_the_swap_file.vim')
call profile#source_profile_file('default', 'rc/20_command_line_editing.vim')
call profile#source_profile_file('default', 'rc/21_executing_external_commands.vim')
call profile#source_profile_file('default', 'rc/22_running_make_and_jumping_to_errors.vim')
call profile#source_profile_file('default', 'rc/23_language_specific.vim')
call profile#source_profile_file('default', 'rc/24_multi_byte_characters.vim')
call profile#source_profile_file('default', 'rc/25_various.vim')

" Leader/LocalLeader
let g:mapleader = ','
let g:maplocalleader = 'm'
nnoremap <LocalLeader> <Nop>
xnoremap <LocalLeader> <Nop>
nnoremap <leader> <Nop>
xnoremap <leader> <Nop>
" remote plugin prog
let g:python_host_prog = expand('~/.anyenv/envs/pyenv/versions/neovim2/bin/python')
let g:python3_host_prog = expand('~/.anyenv/envs/pyenv/versions/neovim3/bin/python')
let g:ruby_host_prog = 'ruby'
let g:node_host_prog = 'node'

filetype indent plugin on
syntax on

" terminal key-bind
tnoremap <c-w>h <C-\><C-N><C-w>h
tnoremap <c-w>j <C-\><C-N><C-w>j
tnoremap <c-w>k <C-\><C-N><C-w>k
tnoremap <c-w>l <C-\><C-N><C-w>l

augroup vim-local
  autocmd!
  autocmd VimEnter * call vim#local#load(expand('<afile>:p:h'))
augroup END

colorscheme iceberg

" vim: foldmethod=marker
