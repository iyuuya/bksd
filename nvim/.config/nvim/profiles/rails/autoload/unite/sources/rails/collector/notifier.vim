"
" gather candidates
"
function! unite#sources#rails#collector#notifier#candidates(source)
  let target = a:source.source__rails_root . '/app/notifiers'
  return unite#sources#rails#helper#gather_candidates_file(target)
endfunction
