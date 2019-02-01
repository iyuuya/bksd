let g:lf_path = expand('$GOPATH/bin/lf')

function! LF()
  let temp = tempname()
  exec 'silent !' . g:lf_path . ' -selection-path=' . shellescape(temp)
  if !filereadable(temp)
    redraw!
    return
  endif
  let names = readfile(temp)
  if empty(names)
    redraw!
    return
  endif
  exec 'edit ' . fnameescape(names[0])
  for name in names[1:]
    exec 'argadd ' . fnameescape(name)
  endfor
  redraw!
endfunction

command! -bar LF call LF()
