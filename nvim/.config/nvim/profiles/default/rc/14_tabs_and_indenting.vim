" Tabs_and_indenting: "{{{1
" 
" number of spaces a <Tab> in the text stands for
set tabstop=2
" number of spaces used for each step of (auto)indent
set shiftwidth=2
" smarttab	a <Tab> in an indent inserts 'shiftwidth' spaces
set smarttab
" if non-zero, number of spaces to insert for a <Tab>
set softtabstop=2
" round to 'shiftwidth' for "<<" and ">>"
set shiftround
" expand <Tab> to spaces in Insert mode
set expandtab
" automatically set the indent of a new line
set autoindent
" do clever autoindenting
set smartindent
" cindent	enable specific indenting for C code
" 	(local to buffer)
"  	set nocin	cin
" cinoptions	options for C-indenting
" 	(local to buffer)
"  	set cino=
" cinkeys	keys that trigger C-indenting in Insert mode
" 	(local to buffer)
"  	set cink=0{,0},0),:,0#,!^F,o,O,e
" cinwords	list of words that cause more C-indent
" 	(local to buffer)
"  	set cinw=if,else,while,do,for,switch
" indentexpr	expression used to obtain the indent of a line
" 	(local to buffer)
"  	set inde=GetVimIndent()
" indentkeys	keys that trigger indenting with 'indentexpr' in Insert mode
" 	(local to buffer)
"  	set indk=0{,0},:,0#,!^F,o,O,e,=end,=else,=cat,=fina,=END,0\\
" copyindent	copy whitespace for indenting from previous line
" 	(local to buffer)
"  	set noci	ci
" preserveindent	preserve kind of whitespace when changing indent
" 	(local to buffer)
"  	set nopi	pi
" lisp	enable lisp mode
" 	(local to buffer)
"  	set nolisp	lisp
" lispwords	words that change how lisp indenting works
"  	set lw=defun,define,defmacro,set!,lambda,if,case,let,flet,let*,letrec,do,do*,define-syntax,let-syntax,letrec-syntax,destructuring-bind,defpackage,defparameter,defstruct,deftype,defvar,do-all-symbols,do-external-symbols,do-symbols,dolist,dotimes,ecase,etypecase,eval-when,labels,macrolet,multiple-value-bind,multiple-value-call,multiple-value-prog1,multiple-value-setq,prog1,progv,typecase,unless,unwind-protect,when,with-input-from-string,with-open-file,with-open-stream,with-output-to-string,with-package-iterator,define-condition,handler-bind,handler-case,restart-bind,restart-case,with-simple-restart,store-value,use-value,muffle-warning,abort,continue,with-slots,with-slots*,with-accessors,with-accessors*,defclass,defmethod,print-unreadable-object
" }}}1
