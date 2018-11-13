" Displaying_text: "{{{1
" 
" scroll	number of lines to scroll for CTRL-U and CTRL-D
" 	(local to window)
"  	set scr=10
" number of screen lines to show around the cursor
set scrolloff=5
" long lines wrap
set wrap
" linebreak	wrap long lines at a character in 'breakat'
set linebreak
" breakindent	preserve indentation in wrapped text
" 	(local to window)
"  	set nobri	bri
" breakindentopt	adjust breakindent behaviour
" 	(local to window)
"  	set briopt=
" which characters might cause a line break
set breakat=\ \>;:,!
" string to put before wrapped screen lines
set showbreak=>\ 
" minimal number of columns to scroll horizontally
set sidescroll=0
" minimal number of columns to keep left and right of the cursor
set sidescrolloff=0
" include "lastline" to show the last line even if it doesn't fit
" 	include "uhex" to show unprintable characters as a hex number
set display=lastline
" fillchars	characters to use for the status line, folds and filler lines
"  	set fcs=
" number of lines used for the command-line
set cmdheight=2
" columns	width of the display
"  	set co=143
" lines	number of lines in the display
"  	set lines=44
" window	number of lines to scroll for CTRL-F and CTRL-B
"  	set window=43
" don't redraw while executing macros
set lazyredraw
" redrawtime	timeout for 'hlsearch' and :match highlighting in msec
"  	set rdt=2000
" writedelay	delay in msec for each char written to the display
" 	(for debugging)
"  	set wd=0
" list	show <Tab> as ^I and end-of-line as $
set list
" list of strings used for list mode
set listchars=tab:>-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
" show the line number for each line
set number
" show the relative line number for each line
set norelativenumber
" number of columns to use for the line number
set numberwidth=4
" controls whether concealable text is hidden
set conceallevel=0
" modes in which text in the cursor line can be concealed
set concealcursor=
" }}}1
