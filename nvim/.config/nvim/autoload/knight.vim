scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim

function! knight#run(source, ...)
  call call('knight#source#' . a:source . '#run', a:000)
endfunction


let s:sources = ['brew']
function! knight#complete(args, cmdline, pos) abort
  let cmds = split(a:cmdline)[1:]
  if len(sources) == 1
    return []
  else
    return sources
  endif
endfunction

command! -nargs=* -complete=customlist,knight#complete Knight :call knight#run(<f-args>)

let &cpoptions = s:save_cpo
unlet s:save_cpo
