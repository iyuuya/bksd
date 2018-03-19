"===============================================================================
" Command: "{{{1

command! -nargs=0 Bdall :%bd!
command! -range ShuffleLine :'<,'>!ruby -e "puts STDIN.each_line.to_a.shuffle"

" }}}1
"===============================================================================
" vim: foldmethod=marker
