"===============================================================================
" Note: "{{{1
" .vimrc
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

source ~/.vim/rc/initialize.vim
source ~/.vim/rc/encoding.vim
source ~/.vim/rc/search.vim
source ~/.vim/rc/edit.vim
source ~/.vim/rc/view.vim
source ~/.vim/rc/syntax.vim
source ~/.vim/rc/plugins.vim
source ~/.vim/rc/key_mapping.vim
source ~/.vim/rc/function.vim
source ~/.vim/rc/platform.vim

" Enable syntax color.
syntax on

" Enable mouse support.
set mouse=a

" Use Japanese or English help.
" 真のVimmerはen
set helplang& helplang=ja,en

set secure

" vim: foldmethod=marker
