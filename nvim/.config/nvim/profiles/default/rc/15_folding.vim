" Folding: "{{{1
" 
" set to display all folds open
set foldenable
" foldlevel	folds with a level higher than this number will be closed
"  	set fdl=0
" value for 'foldlevel' when starting to edit a file
set foldlevelstart=99
" width of the column used to indicate folds
set foldcolumn=2
" foldtext	expression used to display the text of a closed fold
" 	(local to window)
"  	set fdt=foldtext()
" foldclose	set to "all" to close a fold when the cursor leaves it
"  	set fcl=
" foldopen	specifies for which commands a fold will be opened
"  	set fdo=block,hor,mark,percent,quickfix,search,tag,undo
" foldminlines	minimum number of screen lines for a fold to be closed
" 	(local to window)
"  	set fml=1
" commentstring	template for comments; used to put the marker in
"  	set cms=\"%s
" folding type: "manual", "indent", "expr", "marker" or "syntax"
set foldmethod=syntax
" foldexpr	expression used when 'foldmethod' is "expr"
" 	(local to window)
"  	set fde=0
" foldignore	used to ignore lines when 'foldmethod' is "indent"
" 	(local to window)
"  	set fdi=#
" foldmarker	markers used when 'foldmethod' is "marker"
" 	(local to window)
"  	set fmr={{{,}}}
" foldnestmax	maximum fold depth for when 'foldmethod is "indent" or "syntax"
" 	(local to window)
"  	set fdn=20
" }}}1 
