"===============================================================================
" Note: "{{{1
" .config/nvim/init.vim
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
source ~/.config/nvim/rc/types.vim
source ~/.config/nvim/rc/function.vim
source ~/.config/nvim/rc/command.vim
source ~/.config/nvim/rc/key_mapping.vim
source ~/.config/nvim/rc/platform.vim
source ~/.config/nvim/rc/plugins.vim

" Enable syntax color.
syntax on

" Disable mouse support.
set mouse=

" Use Japanese or English help.
" 真のVimmerはen
set helplang& helplang=ja,en

set termguicolors
colorscheme iceberg

set secure

augroup vimrc-local
  autocmd!
  autocmd VimEnter * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let l:files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(l:files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

" vim: foldmethod=marker
