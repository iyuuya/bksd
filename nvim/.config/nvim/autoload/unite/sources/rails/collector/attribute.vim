"
" gather candidates
"
function! unite#sources#rails#collector#attribute#candidates(source)
  let target = a:source.source__rails_root . '/app/attributes'
  return unite#sources#rails#helper#gather_candidates_file(target)
endfunction
