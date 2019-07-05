" Tags: "{{{1
" 
" use binary searching in tags files
set tagbsearch
" taglength	number of significant characters in a tag name or zero
"  	set tl=0
" list of file names to search for tags
set tag=./tags;,tags
" tagcase	how to handle case when searching in tags files:
" 	"followic" to follow 'ignorecase', "ignore" or "match"
" 	(global or local to buffer)
"  	set tc=followic
" tagrelative	file names in a tags file are relative to the tags file
"  	set tr	notr
" tagstack	a :tag command will use the tagstack
"  	set tgst	notgst
" when completing tags in Insert mode show more info
set showfulltag
" cscopeprg	command for executing cscope
"  	set csprg=cscope
" cscopetag	use cscope for tag commands
"  	set nocst	cst
" cscopetagorder	0 or 1; the order in which ":cstag" performs a search
"  	set csto=0
" cscopeverbose	give messages when adding a cscope database
"  	set csverb	nocsverb
" cscopepathcomp	how many components of the path to show
"  	set cspc=0
" cscopequickfix	when to open a quickfix window for cscope
"  	set csqf=
" cscoperelative	file names in a cscope file are relative to that file
"  	set nocsre	csre
" }}}1 