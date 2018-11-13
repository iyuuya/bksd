" Terminal: "{{{1
" 
" scrolljump	minimal number of lines to scroll at a time
"  	set sj=1
" show info in the window title
set title
" percentage of 'columns' used for the window title
set titlelen=100
" when not empty, string to be used for the window title
if my#sys#iswin()
  set titlestring=%<%F\ -\ Vim " %{expand("%:p:.")} \ [%{getfperm(expand('$p'))}]\ %<\ -\ Vim
else
  let &titlestring="%{expand('%:p:.')}%(%m%r%w%) [%{getfperm(expand('%p'))}] %< - Vim"
endif
" titleold	string to restore the title to when exiting Vim
"  	set titleold=
" icon	set the text of the icon for this window
"  	set noicon	icon
" iconstring	when not empty, text for the icon of this window
"  	set iconstring=
" }}}1
