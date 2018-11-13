" Multiple_windows: "{{{1
" 
" 0, 1 or 2; when to use a status line for the last window
set laststatus=2
" alternate format to be used for a status line
let &statusline="%<%f%=%m%r%w%y[%{(&fenc!=''?&fenc:&enc)}][%{&ff}][%04l:%03v/%p%%]"
" make all windows the same size when adding/removing windows
set noequalalways
" eadirection	in which direction 'equalalways' works: "ver", "hor" or "both"
"  	set ead=both
" winheight	minimal number of lines used for the current window
"  	set wh=1
" winminheight	minimal number of lines used for any window
"  	set wmh=1
" winfixheight	keep the height of the window
" 	(local to window)
"  	set nowfh	wfh
" winfixwidth	keep the width of the window
" 	(local to window)
"  	set nowfw	wfw
" winwidth	minimal number of columns used for the current window
"  	set wiw=20
" winminwidth	minimal number of columns used for any window
"  	set wmw=1
" initial height of the help window
set helpheight=15
" default height for the preview window
set previewheight=5
" previewwindow	identifies the preview window
" 	(local to window)
"  	set nopvw	pvw
" hidden	don't unload a buffer when no longer shown in a window
"  	set nohid	hid
" switchbuf	"useopen" and/or "split"; which window to use when jumping
" 	to a buffer
"  	set swb=
" a new window is put below the current one
set splitbelow
" a new window is put right of the current one
set splitright
" scrollbind	this window scrolls together with other bound windows
" 	(local to window)
"  	set noscb	scb
" scrollopt	"ver", "hor" and/or "jump"; list of options for 'scrollbind'
"  	set sbo=ver,jump
" cursorbind	this window's cursor moves together with other bound windows
" 	(local to window)
"  	set nocrb	crb
" }}}1 
