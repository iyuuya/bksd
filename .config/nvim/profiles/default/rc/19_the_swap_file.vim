" The_swap_file: "{{{1
" 
" list of directories for the swap file
call my#futil#mkdir_p(g:nvim_data_path . '/swap')
let &directory=g:nvim_data_path . '/swap'
" use a swap file for this buffer
set swapfile
" updatecount	number of characters typed to cause a swap file update
"  	set uc=200
" time in msec after which the swap file will be updated
set updatetime=200
" }}}1 
