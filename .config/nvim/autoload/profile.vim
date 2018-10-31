scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim

function! profile#load_profiles(...)
  for name in a:000
    call profile#source_profile_file(name, 'init.vim')
  endfor
endfunction

function! profile#get_list(lead, line, pos)
  let l:directories = glob(fnameescape(g:profile_directory) . '/*/', 1, 1)
  return map(l:directories, 'fnamemodify(v:val, ":h:t")')
endfunction

function! profile#path(name)
  return g:profile_directory . '/' . a:name
endfunction

function! profile#source_profile_file(name, filename)
  execute 'source ' . fnameescape(profile#path(a:name) . '/' . a:filename)
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
