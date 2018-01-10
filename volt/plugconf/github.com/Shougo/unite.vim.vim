function! s:config()
  let g:unite_data_directory = expand('~/.local/share/vim/unite.vim')
endfunction

function! s:loaded_on()
  return 'excmd=Unite'
endfunction

function! s:depends()
  return []
endfunction
