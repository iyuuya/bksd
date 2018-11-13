" Editing_text: "{{{1
" 
" undolevels	maximum number of changes that can be undone
" 	(global or local to buffer)
"  	set ul=1000
" automatically save and restore undo history
set undofile
" list of directories for undo files
call my#futil#mkdir_p(g:nvim_data_path . '/undo')
let &undodir=g:nvim_data_path . '/undo'
" undoreload	maximum number lines to save for undo on a buffer reload
"  	set ur=10000
" modified	changes have been made and not written to a file
" 	(local to buffer)
"  	set nomod	mod
" readonly	buffer is not to be written
" 	(local to buffer)
"  	set noro	ro
" modifiable	changes to the text are not possible
" 	(local to buffer)
"  	set ma	noma
" line length above which to break a line
set textwidth=0
" wrapmargin	margin from the right in which to break a line
" 	(local to buffer)
"  	set wm=0
" specifies what <BS>, CTRL-W, etc. can do in Insert mode
set bs=indent,eol,start
" comments	definition of what comment lines look like
" 	(local to buffer)
"  	set com=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"
" formatoptions	list of flags that tell how automatic formatting works
" 	(local to buffer)
"  	set fo=jcroql
" formatlistpat	pattern to recognize a numbered list
" 	(local to buffer)
"  	set flp=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
" formatexpr	expression used for "gq" to format lines
" 	(local to buffer)
"  	set fex=
" specifies how Insert mode completion works for CTRL-N and CTRL-P
set complete=.,t,i,w,b,u
" whether to use a popup menu for Insert mode completion
set completeopt=menuone,preview
" maximum height of the popup menu
set pumheight=20
" completefunc	user defined function for Insert mode completion
" 	(local to buffer)
"  	set cfu=
" omnifunc	function for filetype-specific Insert mode completion
" 	(local to buffer)
"  	set ofu=
" dictionary	list of dictionary files for keyword completion
" 	(global or local to buffer)
"  	set dict=
" thesaurus	list of thesaurus files for keyword completion
" 	(global or local to buffer)
"  	set tsr=
" adjust case of a keyword completion match
set infercase
" digraph	enable entering digraphs with c1 <BS> c2
"  	set nodg	dg
" tildeop	the "~" command behaves like an operator
"  	set notop	top
" operatorfunc	function called for the"g@"  operator
"  	set opfunc=
" when inserting a bracket, briefly jump to its match
set showmatch
" tenth of a second to show a match for 'showmatch'
set matchtime=3
" list of pairs that match for the "%" command
set matchpairs=(:),{:},[:],<:>
" joinspaces	use two spaces after '.' when joining a line
"  	set js	nojs
" nrformats	"alpha", "octal" and/or "hex"; number formats recognized for
" 	CTRL-A and CTRL-X commands
" 	(local to buffer)
"  	set nf=bin,hex
" }}}1 
