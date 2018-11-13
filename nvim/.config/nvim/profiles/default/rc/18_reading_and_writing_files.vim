" Reading_and_writing_files: "{{{1
" 
" enable using settings from modelines when reading a file
set modeline
" number of lines to check for modelines
set modelines=5
" binary	binary file editing
" 	(local to buffer)
"  	set nobin	bin
" endofline	last line in the file has an end-of-line
" 	(local to buffer)
"  	set eol	noeol
" fixendofline	fixes missing end-of-line at end of text file
" 	(local to buffer)
"  	set fixeol	nofixeol
" bomb	prepend a Byte Order Mark to the file
" 	(local to buffer)
"  	set nobomb	bomb
" fileformat	end-of-line format: "dos", "unix" or "mac"
" 	(local to buffer)
"  	set ff=unix
" fileformats	list of file formats to look for when editing a file
"  	set ffs=unix,dos,mac
" 	(local to buffer)
" write	writing files is allowed
"  	set write	nowrite
" write a backup file before overwriting a file
set nowritebackup
" keep a backup after overwriting a file
set backup
" backupskip	patterns that specify for which files a backup is not made
"  	set bsk=/tmp/*,/var/folders/b3/46x3g_j95jxfx9sbtj4pflt40000gp/T/*
" backupcopy	whether to make the backup as a copy or rename the existing file
" 	(global or local to buffer)
"  	set bkc=auto
" list of directories to put backup files in
call my#futil#mkdir_p(g:nvim_data_path . '/backup')
let &backupdir=g:nvim_data_path . '/backup'
" backupext	file name extension for the backup file
"  	set bex=~
" autowrite	automatically write a file when leaving a modified buffer
"  	set noaw	aw
" autowriteall	as 'autowrite', but works with more commands
"  	set noawa	awa
" writeany	always write without asking for confirmation
"  	set nowa	wa
" automatically read a file when it was modified outside of Vim
set autoread
" patchmode	keep oldest version of a file; specifies file name extension
"  	set pm=
" fsync	forcibly sync the file to disk after writing it
"  	set nofs	fs
" }}}1 
