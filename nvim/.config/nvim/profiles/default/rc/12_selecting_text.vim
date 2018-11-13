" Selecting_text: "{{{1
" 
" selection	"old", "inclusive" or "exclusive"; how selecting text behaves
"  	set sel=inclusive
" selectmode	"mouse", "key" and/or "cmd"; when to start Select mode
" 	instead of Visual mode
"  	set slm=
" "unnamed" to use the * register like unnamed register
" 	"autoselect" to always put selected text on the clipboard
set clipboard& clipboard+=unnamed
if has('gui')
  set clipboard+=autoselect
endif
" keymodel	"startsel" and/or "stopsel"; what special keys can do
"  	set km=
" }}}1
