"=======================================================================================================================
" Note: "{{{1
" File: volt/rc/default/gvimrc.vim
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"=======================================================================================================================

colorscheme iceberg

" 背景透過
set transparency=10

" ウィンドウサイズ(バッファのサイズ、行番号の幅、折り畳み情報などから算出)
function! s:resize_window(width, buf_num)
  let l:width = (a:width + &numberwidth + &foldcolumn) * a:buf_num + 1
  let &columns= l:width
  set lines=200
endfunction


let s:size = get(g:, 'gui_size', 'default')
if s:size == 'default'
  call s:resize_window(160, 2)
elsif s:size == 'memo'
  set columns=160 lines=50
endif

" vim: ts=2 sts=2 sw=2 et fdm=marker
