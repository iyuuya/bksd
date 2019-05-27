"===============================================================================
" Note: "{{{1
" rc/initialize.vim
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================
scriptencoding utf-8

set cpoptions-=m

let g:vim_data_path = expand('~/.local/share/vim')

filetype plugin indent on

augroup MyAutoCmd
  autocmd!
augroup END

set whichwrap+=h,l,<,>,[,],b,s
set startofline
set wrapscan
set incsearch
set ignorecase
set smartcase

set tagbsearch
set tag=./tags;,tags
set showfulltag

set scrolloff=5
set wrap
set linebreak
set breakat=\ \>;:,!
set showbreak=>\ 
set sidescroll=0
set sidescrolloff=0
set display=lastline
set cmdheight=2
set lazyredraw
set list
set listchars=tab:>-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set number
set norelativenumber
set numberwidth=4
set conceallevel=0
set concealcursor=

set background=dark
set synmaxcol=200
set hlsearch
set termguicolors
set nocursorcolumn
set nocursorline
set colorcolumn=0
set nospell
set spelllang=en_us

augroup MyCursorColumnGrp
  autocmd!
  autocmd FileType yaml setlocal cursorcolumn
  autocmd FileType cpp setlocal cursorcolumn=120
augroup END


set laststatus=2
let &statusline="%<%f%=%m%r%w%y[%{(&fenc!=''?&fenc:&enc)}][%{&ff}][%04l:%03v/%p%%][%{fnamemodify(getcwd(),':~:.')}]"
set noequalalways
set helpheight=15
set previewheight=5
set splitbelow
set splitright

set showtabline=2
set tabpagemax=10

set title
set titlelen=100
if my#iswin()
  set titlestring=%<%F\ -\ Vim " %{expand("%:p:.")} \ [%{getfperm(expand('$p'))}]\ %<\ -\ Vim
else
  let &titlestring="%{expand('%:p:.')}%(%m%r%w%) [%{getfperm(expand('%p'))}] %< - Vim"
endif

set mouse=

set showcmd
set ruler
set report=0
set visualbell

set clipboard& clipboard+=unnamed
if has('gui')
  set clipboard+=autoselect
endif

set undofile
call my#mkdir_p(g:vim_data_path . '/undo')
let &undodir=g:vim_data_path . '/undo'
set textwidth=0
set bs=indent,eol,start
set complete=.,t,i,w,b,u
set completeopt=menuone,preview
set pumheight=20
set infercase
set showmatch
set matchtime=3
set matchpairs=(:),{:},[:],<:>

set tabstop=2
set shiftwidth=2
set smarttab
set softtabstop=2
set shiftround
set expandtab
set autoindent
set smartindent

set foldenable
set foldlevelstart=99
set foldcolumn=2
set foldmethod=syntax

set timeout
set ttimeout
set timeoutlen=750
set ttimeoutlen=0

set modeline
set modelines=5
set nowritebackup
set nobackup
set backup
call my#mkdir_p(g:vim_data_path . '/backup')
let &backupdir=g:vim_data_path . '/backup'
set autoread

call my#mkdir_p(g:vim_data_path . '/swap')
let &directory=g:vim_data_path . '/swap'
set swapfile
set updatetime=200

set history=10000
set wildmode=list:longest,list:full
set wildmenu
set cmdwinheight=5

set keywordprg=:help

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

source ~/.vim/rc/encoding.vim

set virtualedit=block
set secure

"============================================================================================

syntax enable
