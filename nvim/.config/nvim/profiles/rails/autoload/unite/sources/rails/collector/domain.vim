"
" gather candidates
"
function! unite#sources#rails#collector#domain#candidates(source)
  let target = a:source.source__rails_root . '/app/domains'
  return unite#sources#rails#helper#gather_candidates_file(target)
endfunction
