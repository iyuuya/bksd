"===============================================================================
" Types: "{{{1

function! EnableJavascript()
  let g:used_javascript_libs = 'jquery,underscore,react,flux,jasmine,d3'
  let b:javascript_lib_use_jquery = 1
  let b:javascript_lib_use_underscore = 1
  let b:javascript_lib_use_react = 1
  let b:javascript_lib_use_flux = 1
  let b:javascript_lib_use_jasmine = 1
  let b:javascript_lib_use_d3 = 1
endfunction

augroup MyAutoCmd
  autocmd BufRead,BufNew *.arb setlocal filetype=ruby
  autocmd BufRead,BufNew *.apib setlocal filetype=apiblueprint
  autocmd BufRead,BufNew *.ts setlocal filetype=typescript
  autocmd BufRead,BufNew *.vue setlocal filetype=html

	autocmd BufRead,BufNew *.go setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4

  autocmd FileType javascript,javascript.jsx call EnableJavascript()
augroup END

" }}}1
"===============================================================================
" vim: foldmethod=marker
