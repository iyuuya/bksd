"===============================================================================
" Function: "{{{1

"-------------------------------------------------------------------------------
" WindowResize: "{{{2

function! GoodWinWidth()
  let w = float2nr((2.0 / 3.0) * &columns)
  if winwidth(0) < w
    execute "vertical resize " . w
  endif
  unlet w
endfunction

function! GoodWinHeight()
  let h = float2nr((2.0 / 3.0) * &lines)
  if winheight(0) < h
    execute "botright resize " . h
  endif
  unlet h
endfunction

" }}}2
"-------------------------------------------------------------------------------

" 雑: GetPageTitle('http://hoge.com/fuga')
" 雑: i<C-r>=GetPageTitle(@*)
function! GetPageTitle(url)
  return system('curl --silent ' . a:url . " | grep '<title>' | sed -e 's/\\<title\\>//g' | sed -e 's/\\<\\/title\\>//g' | sed -e 's/ *$//g' | sed -e 's/^ *//g' | sed -e 's/\\n$//g'")
endfunction

" Jimakun
function! Jimakun(subtitle)
  call system('jimakun "' . a:subtitle . '" &')
endfunction
command! -nargs=1 Jimakun call Jimakun(<f-args>)

" }}}1
"===============================================================================
" vim: foldmethod=marker
