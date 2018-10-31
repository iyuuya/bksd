call profile#source_profile_file('rails', 'rc/plugins.vim')

function! <SID>SetIndentForRuby()
  " let g:ruby_indent_access_modifier_style = 'indent'
  setlocal smartindent autoindent
  setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
endfunction

augroup MyFileTypes
  autocmd BufRead,BufNew *.arb setlocal filetype=ruby
  autocmd FileType ruby call <SID>SetIndentForRuby()
augroup END
