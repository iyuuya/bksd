"===============================================================================
" Types: "{{{1

function! <SID>EnableJavascript()
  let g:used_javascript_libs = 'jquery,underscore,react,flux,jasmine,d3'
  let b:javascript_lib_use_jquery = 1
  let b:javascript_lib_use_underscore = 1
  let b:javascript_lib_use_react = 1
  let b:javascript_lib_use_flux = 1
  let b:javascript_lib_use_jasmine = 1
  let b:javascript_lib_use_d3 = 1
endfunction

function! <SID>SetIndentForPHP()
  setlocal smartindent autoindent
  setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
endfunction

function! <SID>EnableFish()
  compiler fish
  setlocal textwidth=79
  setlocal foldmethod=expr
endfunction

augroup MyFileTypes
  autocmd!
  autocmd BufRead,BufNew *.apib setlocal filetype=apiblueprint
  autocmd BufRead,BufNew *.ts setlocal filetype=typescript
  autocmd BufRead,BufNew *.vue setlocal filetype=html
  autocmd BufRead,BufNew *.ejs setlocal filetype=ejs.html

	autocmd BufRead,BufNew *.go setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufRead,BufNew *.fish setlocal filetype=fish

  autocmd FileType javascript,javascript.jsx,javascript.mocha call <SID>EnableJavascript()
  autocmd FileType fish call <SID>EnableFish()
  autocmd FileType php call <SID>SetIndentForPHP()
augroup END

" }}}1
"===============================================================================
" vim: foldmethod=marker
