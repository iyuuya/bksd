scriptencoding utf-8

function! s:load_localrc()
  if filereadable('.vimrc.local')
    source .vimrc.local
  endif
endfunction

augroup localrc-plugin
  autocmd VimEnter,DirChanged * :call s:load_localrc()
augroup END
