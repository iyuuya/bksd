" Language_specific: "{{{1
" 
" isfname	specifies the characters in a file name
"  	set isf=@,48-57,/,.,-,_,+,,,#,$,%,~,=
" isident	specifies the characters in an identifier
"  	set isi=@,48-57,_,192-255
" iskeyword	specifies the characters in a keyword
" 	(local to buffer)
"  	set isk=@,48-57,_,192-255,#
" isprint	specifies printable characters
"  	set isp=@,161-255
" quoteescape	specifies escape characters in a string
" 	(local to buffer)
"  	set qe=\\
" rightleft	display the buffer right-to-left
" 	(local to window)
"  	set norl	rl
" rightleftcmd	when to edit the command-line right-to-left
" 	(local to window)
"  	set rlc=search
" revins	insert characters backwards
"  	set nori	ri
" allowrevins	allow CTRL-_ in Insert and Command-line mode to toggle 'revins'
"  	set noari	ari
" aleph	the ASCII code for the first letter of the Hebrew alphabet
"  	set al=224
" hkmap	use Hebrew keyboard mapping
"  	set nohk	hk
" hkmapp	use phonetic Hebrew keyboard mapping
"  	set nohkp	hkp
" altkeymap	use Farsi as the second language when 'revins' is set
"  	set noakm	akm
" fkmap	use Farsi keyboard mapping
"  	set nofk	fk
" arabic	prepare for editing Arabic text
" 	(local to window)
"  	set noarab	arab
" arabicshape	perform shaping of Arabic characters
"  	set arshape	noarshape
" termbidi	terminal will perform bidi handling
"  	set notbidi	tbidi
" keymap	name of a keyboard mapping
"  	set kmp=
" langmap	list of characters that are translated in Normal mode
"  	set lmap=
" langremap	apply 'langmap' to mapped characters
"  	set nolrm	lrm
" iminsert	in Insert mode: 1: use :lmap; 2: use IM; 0: neither
" 	(local to window)
"  	set imi=0
" imsearch	entering a search pattern: 1: use :lmap; 2: use IM; 0: neither
" 	(local to window)
"  	set ims=0
" }}}1 