let g:lf_path = '/Users/iyuuya/.go/bin/lf'

function! LF()
  if !exists('g:lf_path')
    echom 'Please let g:lf_path="/path/to/lf"'
    return
  endif
  let l:temp = tempname()
  exec 'silent !' . g:lf_path . ' -selection-path=' . shellescape(l:temp)
  if !filereadable(l:temp)
    redraw!
    return
  endif
  let l:names = readfile(l:temp)
  if empty(l:names)
    redraw!
    return
  endif
  exec 'edit ' . fnameescape(names[0])
  for l:name in l:names[1:]
    exec 'argadd ' . fnameescape(l:name)
  endfor
  redraw!
endfunction
command! -bar LF call LF()
