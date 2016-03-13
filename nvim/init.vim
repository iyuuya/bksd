"===============================================================================
" Note: "{{{1
" nvim/init.vim
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

" sudoの場合は設定を読み込まない
if exists('$SUDO_USER')
  finish
endif

" トロイの木馬対策
set secure

" vim: foldmethod=marker
