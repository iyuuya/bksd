"
" gather candidates
"
function! unite#sources#rails#collector#loyalty#candidates(source)
  let target = a:source.source__rails_root . '/app/loyalties'
  return unite#sources#rails#helper#gather_candidates_file(target)
endfunction
