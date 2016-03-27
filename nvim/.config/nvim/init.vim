"===============================================================================
" Note: "{{{1
" .config/nvim/init.im
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

" sudoの場合は設定を読み込まない
if exists('$SUDO_USER')
  finish
endif

source ~/.config/nvim/rc/initialize.vim
source ~/.config/nvim/rc/encoding.vim
source ~/.config/nvim/rc/search.vim
source ~/.config/nvim/rc/edit.vim
source ~/.config/nvim/rc/view.vim
source ~/.config/nvim/rc/syntax.vim
source ~/.config/nvim/rc/plugins.vim
source ~/.config/nvim/rc/key_mapping.vim
source ~/.config/nvim/rc/function.vim
source ~/.config/nvim/rc/platform.vim

" Enable syntax color.
syntax on

" Enable mouse support.
set mouse=a

" Use Japanese or English help.
" 真のVimmerはen
set helplang& helplang=ja,en

set secure

" vim: foldmethod=marker
