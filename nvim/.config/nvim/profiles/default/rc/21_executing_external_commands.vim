" Executing_external_commands: "{{{1
" 
" shell	name of the shell program used for external commands
"  	set sh=/usr/local/bin/zsh
" shellquote	character(s) to enclose a shell command in
"  	set shq=
" shellxquote	like 'shellquote' but include the redirection
"  	set sxq=
" shellxescape	characters to escape when 'shellxquote' is (
"  	set sxe=
" shellcmdflag	argument for 'shell' to execute a command
"  	set shcf=-c
" shellredir	used to redirect command output to a file
"  	set srr=>%s\ 2>&1
" shelltemp	use a temp file for shell commands instead of using a pipe
"  	set stmp	nostmp
" equalprg	program used for "=" command
" 	(global or local to buffer)
"  	set ep=
" formatprg	program used to format lines with "gq" command
"  	set fp=
" program used for the "K" command
set keywordprg=:help
" warn	warn when using a shell command and a buffer has changes
"  	set warn	nowarn
" }}}1 