" Printing: "{{{1
" 
" printoptions	list of items that control the format of :hardcopy output
"  	set popt=
" printdevice	name of the printer to be used for :hardcopy
"  	set pdev=
" printexpr	expression used to print the PostScript file for :hardcopy
"  	set pexpr=system(['lpr']\ +\ (empty(&printdevice)?[]:['-P',\ &printdevice])\ +\ [v:fname_in]).\ delete(v:fname_in)+\ v:shell_error
" printfont	name of the font to be used for :hardcopy
"  	set pfn=courier
" printheader	format of the header used for :hardcopy
"  	set pheader=%<%f%h%m%=%N\ ページ
" printencoding	encoding used to print the PostScript file for :hardcopy
"  	set penc=
" printmbcharset	the CJK character set to be used for CJK output from :hardcopy
"  	set pmbcs=
" printmbfont	list of font names to be used for CJK output from :hardcopy
"  	set pmbfn=
" }}}1
