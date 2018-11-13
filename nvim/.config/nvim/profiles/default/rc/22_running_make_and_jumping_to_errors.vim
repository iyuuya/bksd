" Running_make_and_jumping_to_errors: "{{{1
" 
" errorfile	name of the file that contains error messages
"  	set ef=errors.err
" errorformat	list of formats for error messages
" 	(global or local to buffer)
"  	set efm=%*[^\"]\"%f\"%*\\D%l:\ %m,\"%f\"%*\\D%l:\ %m,%-G%f:%l:\ (Each\ undeclared\ identifier\ is\ reported\ only\ once,%-G%f:%l:\ for\ each\ function\ it\ appears\ in.),%-GIn\ file\ included\ from\ %f:%l:%c:,%-GIn\ file\ included\ from\ %f:%l:%c\\,,%-GIn\ file\ included\ from\ %f:%l:%c,%-GIn\ file\ included\ from\ %f:%l,%-G%*[\ ]from\ %f:%l:%c,%-G%*[\ ]from\ %f:%l:,%-G%*[\ ]from\ %f:%l\\,,%-G%*[\ ]from\ %f:%l,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,\"%f\"\\,\ line\ %l%*\\D%c%*[^\ ]\ %m,%D%*\\a[%*\\d]:\ Entering\ directory\ %*[`']%f',%X%*\\a[%*\\d]:\ Leaving\ directory\ %*[`']%f',%D%*\\a:\ Entering\ directory\ %*[`']%f',%X%*\\a:\ Leaving\ directory\ %*[`']%f',%DMaking\ %*\\a\ in\ %f,%f\|%l\|\ %m
" makeprg	program used for the ":make" command
" 	(global or local to buffer)
"  	set mp=make
" shellpipe	string used to put the output of ":make" in the error file
"  	set sp=2>&1\|\ tee
" makeef	name of the errorfile for the 'makeprg' command
"  	set mef=
" program used for the ":grep" command / list of formats for output of 'grepprg'
if executable('ag')
  set grepprg=ag\ --nogroup\ -iS
  set grepformat=%f:%l:%m
elseif executable('grep')
  set grepprg=grep\ -Hnd\ skip\ -r
  set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
else
  set grepprg=internal
 	set grepformat&
endif

augroup VimGrepAutoCmd
  autocmd!
  " show grep result on quickfix
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

" makeencoding	encoding of the ":make" and ":grep" output
" 	(global or local to buffer)
"  	set menc=
" }}}1 
