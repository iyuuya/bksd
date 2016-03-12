"===============================================================================
" Function: "{{{1

"-------------------------------------------------------------------------------
" WindowResize: "{{{2

function! GoodWinWidth()
  let s:w = float2nr((2.0 / 3.0) * &columns)
  if winwidth(0) < s:w
    execute "vertical resize " . s:w
  endif
  unlet s:w
endfunction

function! GoodWinHeight()
  let s:h = float2nr((2.0 / 3.0) * &lines)
  if winheight(0) < s:h
    execute "botright resize " . s:h
  endif
  unlet s:h
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
