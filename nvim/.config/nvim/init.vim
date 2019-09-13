" if executable('nvim_server')
"   echo 'a'
" endif

filetype plugin indent on
syntax enable

set nobackup
set noswapfile
set noundofile

set modeline

call my#ft#vim#init()
call my#ft#ruby#init()
call my#ft#javascript#init()

augroup MyAutoCmd
  autocmd!
  autocmd VimEnter,DirChanged * call my#rc#local()
augroup END

set wildmenu
set wildmode=list:longest,list:full

set clipboard=unnamed

" vim: ts=2 sts=2 sw=2 et
