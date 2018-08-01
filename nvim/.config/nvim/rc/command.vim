"===============================================================================
" Command: "{{{1

command! -nargs=0 Bdall :%bd!
command! -range ShuffleLine :'<,'>!ruby -e "puts STDIN.each_line.to_a.shuffle"

" shell
command! -nargs=0 Zsh :vs term://zsh -l
command! -nargs=0 Fish :vs term://fish -l
command! -nargs=0 Bash :vs term://bash -l

" }}}1
"===============================================================================
" vim: foldmethod=marker
