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
