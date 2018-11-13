"  Syntax_highlighting_and_spelling: "{{{1
" 
" "dark" or "light"; the background color brightness
set background=dark
" maximum column to look for syntax items
set synmaxcol=200
" hlsearch	highlight all matches for the last used search pattern
set hlsearch
" use GUI colors for the terminal
set termguicolors
" highlight the screen column of the cursor
set nocursorcolumn
" highlight the screen line of the cursor
set nocursorline
augroup MyCursorColumnGrp
  autocmd!
  autocmd FileType yaml setlocal cursorcolumn
  autocmd FileType cpp setlocal cursorcolumn=120
augroup END
" columns to highlight
set colorcolumn=0
" highlight spelling mistakes
set nospell
" list of accepted languages
set spelllang=en_us
" spellfile	file that "zg" adds good words to
" 	(local to buffer)
"  	set spf=
" spellcapcheck	pattern to locate the end of a sentence
" 	(local to buffer)
"  	set spc=[.?!]\\_[\\])'\"\	\ ]\\+
" spellsuggest	methods used to suggest corrections
"  	set sps=best
" mkspellmem	amount of memory used by :mkspell before compressing
"  	set msm=460000,2000,500
" }}}1 
