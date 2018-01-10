function! s:config()
  let g:unite_data_directory = expand('~/.local/share/vim/unite.vim')
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return []
endfunction
