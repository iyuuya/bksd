"===============================================================================
" Note: "{{{1
" profiles/default/init.vim
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

call profile#source_profile_file('default', 'rc/initialize.vim')
call profile#source_profile_file('default', 'rc/initialize.vim')
call profile#source_profile_file('default', 'rc/encoding.vim')
call profile#source_profile_file('default', 'rc/search.vim')
call profile#source_profile_file('default', 'rc/edit.vim')
call profile#source_profile_file('default', 'rc/view.vim')
call profile#source_profile_file('default', 'rc/syntax.vim')
call profile#source_profile_file('default', 'rc/types.vim')
call profile#source_profile_file('default', 'rc/function.vim')
call profile#source_profile_file('default', 'rc/command.vim')
call profile#source_profile_file('default', 'rc/key_mapping.vim')
call profile#source_profile_file('default', 'rc/platform.vim')
call profile#source_profile_file('default', 'rc/plugins.vim')

" Enable syntax color.
syntax on

" Disable mouse support.
set mouse=

" Use Japanese or English help.
" 真のVimmerはen
set helplang& helplang=ja,en

set termguicolors
colorscheme iceberg

set secure

augroup vimrc-local
  autocmd!
  autocmd VimEnter * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let l:files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(l:files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

" vim: foldmethod=marker
