scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim

if !exists('g:profile_directory')
  if exists('$XDG_CONFIG_HOME')
    let g:profile_directory = expand($XDG_CONFIG_HOME . '/profiles')
  else
    let g:profile_directory = expand('~/.config/nvim/profiles')
  endif
endif

command! -nargs=+ -complete=customlist,profile#get_list Profile :call profile#load_profiles(<f-args>)

let &cpoptions = s:save_cpo
unlet s:save_cpo
