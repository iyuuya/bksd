function! s:config()
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_safe_mode_by_default = 0
  let g:vimfiler_data_directory = expand('~/.local/share/vimfiler.vim')
endfunction

function! s:loaded_on()
  return 'start'
endfunction

function! s:depends()
  return ['github.com/Shougo/unite.vim']
endfunction
