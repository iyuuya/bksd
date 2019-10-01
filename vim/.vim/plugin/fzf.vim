function! FzfDirs(...)
  return fzf#run({
        \ 'source':  "tree -dfiR | sed -e '$d' | sed -e '$d'",
        \ 'sink':    'cd',
        \ 'options': '+m --prompt="Dirs> "'
        \ })
endfunction

command! -bar -bang Dirs call FzfDirs(<bang>0)
