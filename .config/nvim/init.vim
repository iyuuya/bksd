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

let g:profile_directory = expand('~/.config/nvim/profiles')
call profile#load_profiles('default')
" TODO: ディレクトリ毎にどのprofileを読み込むのか設定できるようにする
" (今は代替案としてvimrc.localでどうにかできるものの)
call profile#load_profiles('rails')

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
