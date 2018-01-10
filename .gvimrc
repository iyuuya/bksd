"=======================================================================================================================
" Note: "{{{1
" File: .gvimrc
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"=======================================================================================================================

" 暗い色
set background=dark
" とりあえずデフォルトのカラースキームを使う
colorscheme desert
" 背景透過
set transparency=10

" ウィンドウサイズ(バッファのサイズ、行番号の幅、折り畳み情報などから算出)
function! s:resize_window(width, buf_num)
  let l:width = (a:width + &numberwidth + &foldcolumn) * a:buf_num + 1
  execute 'winsize ' . l:width . ' 1000'
endfunction
call s:resize_window(160, 2)

" vim: ts=2 sts=2 sw=2 et fdm=marker
