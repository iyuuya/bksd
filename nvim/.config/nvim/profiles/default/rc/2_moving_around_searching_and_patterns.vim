" Moving_around_searching_and_patterns: "{{{1
"
" list of flags specifying which commands wrap to another line
set whichwrap+=h,l,<,>,[,],b,s
" many jump commands move the cursor to the first non-blank character of a line
set startofline
" paragraphs	nroff macro names that separate paragraphs
"  	set para=IPLPPPQPP\ TPHPLIPpLpItpplpipbp
" sections	nroff macro names that separate sections
"  	set sect=SHNHH\ HUnhsh
" path	list of directory names used for file searching
" 	(global or local to buffer)
"  	set pa=.,/usr/include,,
" cdpath	list of directory names used for :cd
"  	set cd=,,
" autochdir	change to directory of file in buffer
"  	set noacd	acd
" search commands wrap around the end of the buffer
set wrapscan
" show match for partly typed search command
set incsearch
" magic	change the way backslashes are used in search patterns
"  	set magic	nomagic
" regexpengine	select the default regexp engine used
"  	set re=0
" ignore case when using a search pattern
set ignorecase
" override 'ignorecase' when pattern has upper case characters
set smartcase
" casemap	what method to use for changing case of letters
"  	set cmp=internal,keepascii
" maxmempattern	maximum amount of memory in Kbyte used for pattern matching
"  	set mmp=1000
" define	pattern for a macro definition line
" 	(global or local to buffer)
"  	set def=^\\s*#\\s*define
" include	pattern for an include-file line
" 	(local to buffer)
"  	set inc=^\\s*#\\s*include
" includeexpr	expression used to transform an include line to a file name
" 	(local to buffer)
"  	set inex=
" }}}1
