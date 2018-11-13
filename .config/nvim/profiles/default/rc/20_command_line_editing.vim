" Command_line_editing: "{{{1
" 
" how many command lines are remembered 
set history=10000
" wildchar	key that triggers command-line expansion
"  	set wc=9
" wildcharm	like 'wildchar' but can also be used in a mapping
"  	set wcm=0
" specifies how command line completion works
set wildmode=list:longest,list:full
" suffixes	list of file name extensions that have a lower priority
"  	set su=.bak,~,.o,.h,.info,.swp,.obj
" suffixesadd	list of file name extensions added when searching for a file
" 	(local to buffer)
"  	set sua=
" wildignore	list of patterns to ignore files for file name completion
"  	set wig=
" fileignorecase	ignore case when using file names
"  	set nofic	fic
" wildignorecase	ignore case when completing file names
"  	set nowic	wic
" command-line completion shows a list of matches
set wildmenu
" cedit	key used to open the command-line window
"  	set cedit=
" height of the command-line window
set cmdwinheight=5
" }}}1
