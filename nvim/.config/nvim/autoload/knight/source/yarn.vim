scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim

function! knight#source#yarn#run(...)
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
