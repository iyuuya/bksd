if exists('g:loaded_my')
  finish
endif
let g:loaded_my = 1

augroup MyAutoCmd
  autocmd!
  autocmd VimEnter,DirChanged * call my#rc#local()
augroup END
