"===============================================================================
" Note: "{{{1
" .vimrc
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

if exists('$SUDO_USER')
  finish
endif

if has('vim_starting') && &compatible
  set nocompatible
endif

let $MYVIMFILES = expand('~/.config/vim')
execute 'set runtimepath^=' . $MYVIMFILES

if my#iswin()
  language message en
else
  language message C
endif
language ctype C
language time C

let mapleader = ','
let maplocalleader = 'm'

nnoremap <LocalLeader> <Nop>
xnoremap <LocalLeader> <Nop>
nnoremap <leader> <Nop>
xnoremap <leader> <Nop>

" tmp directory.
if !exists('g:vim_tmp_directory')
  let g:vim_tmp_directory = $MYVIMFILES . "/tmp"
endif

" Create tmp directory.
call my#mkdir_p(g:vim_tmp_directory)

filetype indent plugin on
syntax enable

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932
set fileformat=unix
set fileformats=unix,dos,mac

"===============================================================================
" Search: "{{{1

set ignorecase
set smartcase
set infercase
set incsearch
set hlsearch
set wrapscan

if has('migemo')
  set migemo
endif

" }}}1
"===============================================================================

"===============================================================================
" Edit: "{{{1

call my#mkdir_p(g:vim_tmp_directory.'/backup')
call my#mkdir_p(g:vim_tmp_directory.'/swap')
call my#mkdir_p(g:vim_tmp_directory.'/undo')

set backup
set nowritebackup
let &backupdir=g:vim_tmp_directory.'/backup'
set swapfile
let &directory=g:vim_tmp_directory.'/swap'
set undofile
let &undodir=g:vim_tmp_directory.'/undo'

set updatetime=200

set timeout
set timeoutlen=750
set ttimeoutlen=200

set backspace=indent,eol,start

set clipboard&
set clipboard+=unnamed
if has('gui')
  set clipboard+=autoselect
endif

set autoread

set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround

set smarttab
set expandtab

set modeline

set foldenable
set foldlevelstart=99
set foldcolumn=1
set foldmethod=syntax

augroup FoldAutoGroup
  autocmd!
  autocmd FileType html,erb,haml,yaml setlocal foldmethod=indent
  autocmd InsertEnter * if !exists('w:last_fdm')
        \| let w:last_fdm=&foldmethod
        \| setlocal foldmethod=manual
        \| endif
  autocmd InsertLeave,WinLeave * if exists('w:last_fdm')
        \| let &l:foldmethod=w:last_fdm
        \| unlet w:last_fdm
        \| endif
augroup END

if executable('ag')
  set grepprg=ag\ --nogroup\ -iS
  set grepformat=%f:%l:%m
elseif executable('grep')
  set grepprg=grep\ -Hnd\ skip\ -r
  set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
else
  set grepprg=internal
endif

augroup VimGrepAutoCmd
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

" Set tags file.
set tags=./tags,tags

if v:version < 7.3 || (v:version == 7.3 && has('patch336'))
  " Vim's bug.
  set notagbsearch
endif

" Enable virtualedit in visual block mode.
set virtualedit=block

" Set keyword help. (K)
set keywordprg=:help
" default: set keywordprg=man\ -s
" will use unite.vim or ref.vim if can

" Increase history amount.
set history=10000

" }}}1
"===============================================================================

"===============================================================================
" View: "{{{1

set number
set numberwidth=4
set norelativenumber
set ruler

set wrap
set whichwrap+=h,l,<,>,[,],b,s
set textwidth=0
set sidescroll=0
set linebreak
set showbreak=>\ 
set breakat=\ \>;:,!
set breakindent

set list
set listchars=tab:>-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

set showmatch
set matchpairs+=<:>
set cpoptions-=m
set matchtime=3
set colorcolumn=0

set laststatus=2
set cmdheight=2
set showcmd

let &statusline="%<%f%=%m%r%w%y[%{(&fenc!=''?&fenc:&enc)}][%{&ff}][%04l:%03v/%p%%]"

set title
set titlelen=100
if my#iswin()
  set titlestring=%<%F\ -\ Vim " %{expand("%:p:.")} \ [%{getfperm(expand('$p'))}]\ %<\ -\ Vim
else
  let &titlestring="%{expand('%:p:.')}%(%m%r%w%) [%{getfperm(expand('%p'))}] %< - Vim"
endif

set showtabline=2
set tabpagemax=10

set previewheight=5
set helpheight=15

set showfulltag

set wildmenu
set wildmode=list:longest,list
set wildoptions=tagfile

set scrolloff=5

set completeopt=menuone,preview
set complete=.,t,i,w,b,u
set pumheight=20

set splitright
set splitbelow
set noequalalways

set cmdwinheight=5

set display=lastline

set startofline

set cursorline
augroup MyCursorColumnGrp
  autocmd!
  autocmd FileType yaml setlocal cursorcolumn
augroup END

augroup CppColorColumnGrp
  autocmd!
  autocmd FileType cpp setlocal colorcolumn=120
augroup END

set nospell spelllang=en_us

set visualbell
set vb t_vb=

set t_Co=256

set report=0

set lazyredraw

set synmaxcol=200

augroup vimrc-highlight
  autocmd!
  autocmd Syntax * if 10000 < line('$') | syntax sync minlines=100 | endif
augroup END
" }}}1
"===============================================================================

"===============================================================================
" Key Mapping: "{{{1

nnoremap <Space> :
vnoremap <space> :

inoremap <c-f> <esc>

cmap <c-h> <left>
cmap <c-l> <right>
cmap <c-e> <end>
cmap <c-a> <home>

nnoremap M `

nnoremap <Tab>= ggvG=2<C-o>

nnoremap <C-q> <C-^>

vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv

nnoremap [mybind] Nop
nmap <C-e> [mybind]

nnoremap <silent> [mybind]tw :<C-u>setlocal wrap! wrap?<CR>

if exists('$MYVIMRC')
  nnoremap <silent> [mybind]v :<C-u>e $MYVIMRC<CR>
  nnoremap [mybind]V :<C-u>source $MYVIMRC<CR>
endif
if exists('$MYGVIMRC')
  nnoremap <silent> [mybind]gv :<C-u>e $MYGVIMRC<CR>
  nnoremap [mybind]gV :<C-u>source $MYGVIMRC<CR>
endif

nnoremap <silent> [mybind]h <c-w>h:call GoodWinWidth()<cr>
nnoremap <silent> [mybind]j <c-w>j:call GoodWinHeight()<cr>
nnoremap <silent> [mybind]k <c-w>k:call GoodWinHeight()<cr>
nnoremap <silent> [mybind]l <c-w>l:call GoodWinWidth()<cr>

nnoremap <silent> [mybind]eu :<C-u>setlocal fenc=utf-8<CR>
nnoremap <silent> [mybind]ee :<C-u>setlocal fenc=euc-jp<CR>
nnoremap <silent> [mybind]es :<C-u>setlocal fenc=cp932<CR>
nnoremap <silent> [mybind]eU :<C-u>e ++enc=utf-8 %<CR>
nnoremap <silent> [mybind]eE :<C-u>e ++enc=euc-jp %<CR>
nnoremap <silent> [mybind]eS :<C-u>e ++enc=cp932 %<CR>

nnoremap <silent> [mybind]el :<C-u>setlocal fileformat=unix<CR>
nnoremap <silent> [mybind]em :<C-u>setlocal fileformat=mac<CR>
nnoremap <silent> [mybind]ed :<C-u>setlocal fileformat=dos<CR>
nnoremap <silent> [mybind]eL :<C-u>e ++fileformat=unix %<CR>
nnoremap <silent> [mybind]eM :<C-u>e ++fileformat=mac %<CR>
nnoremap <silent> [mybind]eD :<C-u>e ++fileformat=dos %<CR>

nnoremap <silent> [mybind]fm :<C-u>setlocal foldmethod=marker<CR>
nnoremap <silent> [mybind]fi :<C-u>setlocal foldmethod=indent<CR>
nnoremap <silent> [mybind]fs :<C-u>setlocal foldmethod=syntax<CR>

nnoremap <silent> [mybind]cc :<C-u>let &colorcolumn = &colorcolumn == 0 ? 80 : 0<CR>
nnoremap <silent> [mybind]cl :<C-u>set cursorline!<CR>
nnoremap <silent> [mybind]cn :<C-u>set cursorcolumn!<CR>
nnoremap <silent> [mybind]tn :<C-u>set relativenumber!<CR>

nnoremap <silent> [mybind]/  :vimgrep  %<left><left>
nnoremap <silent> [mybind]n  :cnext<CR>
nnoremap <silent> [mybind]N  :cprevious<CR>

" }}}1
"===============================================================================

" vim: foldmethod=marker tabstop=2 softtabstop=2 shiftwidth=2 expandtab
