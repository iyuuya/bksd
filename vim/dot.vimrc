"===============================================================================
" Note: "{{{1
" .vimrc
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

"===============================================================================
" Initialize: "{{{1

"-------------------------------------------------------------------------------
" Initialize Options: "{{{2

" Enable no Vi compatible commands.
set nocompatible

" Check platform "{{{3
let s:iswin = has('win32') || has('win64') || has('win95') || has('win16')
let s:iscygwin = has('win32unix')
let s:ismac = has('mac') || has('macunix') || has('gui_mac') || has('gui_macvim') ||
      \ (!executable('xdg-open') && system('uname') =~? '^darwin')
let s:islinux = !s:iswin && !s:iscygwin && !s:ismac
" }}}3

if s:iswin
  language message en
else
  language message C
endif
language ctype C
language time C

let mapleader = ','
let maplocalleader = 'm'

nnoremap m <Nop>
xnoremap m <Nop>
nnoremap , <Nop>
xnoremap , <Nop>

if s:iswin
  set shellslash
endif

" environment variables.
if !exists("$MYVIMRC")
  let $MYVIMRC = expand('~/.vimrc')
endif

if !exists("$MYGVIMRC")
  let $MYGVIMRC = expand('~/.gvimrc')
endif

if !exists("$MYVIMFILES")
  if s:iswin
    let $MYVIMFILES = expand('~/vimfiles')
  else
    let $MYVIMFILES = expand('~/.vim')
  endif
endif

augroup MyAutoCmd
  autocmd!
augroup END

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" NeoBundle: "{{{2

if has('vim_starting')
  set runtimepath+=$MYVIMFILES/bundle/neobundle.vim
endif

if globpath(&rtp, 'bundle/neobundle.vim') != ''
  filetype off
  call neobundle#rc('$MYVIMFILES/bundle/')

  " Ultimate Vim package manager
  NeoBundleFetch 'Shougo/neobundle.vim'

  " Interactive command execution in Vim.
  NeoBundle 'Shougo/vimproc', {
        \ 'build' : {
        \   'win64' : 'nmake -f make_msvc32.mak',
        \   'win32' : 'nmake -f make_msvc64.mak',
        \   'mac'   : 'make -f make_mac.mak',
        \   'unix'  : 'make -f make_unix.mak',
        \   },
        \ }
endif


" }}}2
"-------------------------------------------------------------------------------

filetype indent on
filetype plugin on

" }}}1
"===============================================================================

"===============================================================================
" Encoding: "{{{1

" The automatic recognition of the character code.

" Setting of the encoding to use for a save and reading.
" Make it normal in UTF-8 in Unix.
set encoding=utf-8

" Setting of terminal encoding."{{{
if !has('gui_running')
  if &term ==# 'win32' && (v:version < 703 || (v:version == 703 && has('patch814')))
    " Setting when use the non-GUI Japanese console.

    " Garbled unless set this.
    set termencoding=cp932
    " Japanese input changes itself unless set this.  Be careful because the
    " automatic recognition of the character code is not possible!
    set encoding=japan
  else
    if $ENV_ACCESS ==# 'linux'
      set termencoding=euc-jp
    elseif $ENV_ACCESS ==# 'colinux'
      set termencoding=utf-8
    else  " fallback
      set termencoding=  " same as 'encoding'
    endif
  endif
elseif s:iswin
  " For system.
  set termencoding=cp932
endif
"}}}

" The automatic recognition of the character code."{{{
if !exists('did_encoding_settings') && has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'

  " Does iconv support JIS X 0213?
  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213,euc-jp'
    let s:enc_jis = 'iso-2022-jp-3'
  endif

  " Build encodings.
  let &fileencodings = 'ucs-bom'
  if &encoding !=# 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'ucs-2le'
    let &fileencodings = &fileencodings . ',' . 'ucs-2'
  endif
  let &fileencodings = &fileencodings . ',' . s:enc_jis

  if &encoding ==# 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'cp932'
  elseif &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    let &encoding = s:enc_euc
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . 'cp932'
  else  " cp932
    let &fileencodings = &fileencodings . ',' . 'utf-8'
    let &fileencodings = &fileencodings . ',' . s:enc_euc
  endif
  let &fileencodings = &fileencodings . ',' . &encoding

  unlet s:enc_euc
  unlet s:enc_jis

  let did_encoding_settings = 1
endif
"}}}

if has('kaoriya')
  " For Kaoriya only.
  set fileencodings=guess
endif

" When do not include Japanese, use encoding for fileencoding.
function! s:ReCheck_FENC() "{{{
  let is_multi_byte = search("[^\x01-\x7e]", 'n', 100, 100)
  if &fileencoding =~# 'iso-2022-jp' && !is_multi_byte
    let &fileencoding = &encoding
  endif
endfunction"}}}

autocmd MyAutoCmd BufReadPost * call s:ReCheck_FENC()

" Default fileformat.
set fileformat=unix
" Automatic recognition of a new line cord.
set fileformats=unix,dos,mac

if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif

" }}}1
"===============================================================================

"===============================================================================
" Search: "{{{1

" Ignore the case of normal letters.
set ignorecase
" If the search pattern contains upper case characters,
" override ignorecase option.
set smartcase
" Ignore case on insert completion.
set infercase

" Enable incremental search.
set incsearch
" Don't highlight search result.
set hlsearch

" Searches wrap around the end of the file.
set wrapscan

" Use migemo
if has('migemo')
  set migemo
endif

" }}}1
"===============================================================================

"===============================================================================
" Edit: "{{{1

" tmp directory.
if !exists('g:vim_tmp_directory')
  let g:vim_tmp_directory = $HOME."/.vimtmp"
endif

" Create tmp directory.
if !isdirectory(g:vim_tmp_directory)
  call mkdir(g:vim_tmp_directory)
endif
if !isdirectory(g:vim_tmp_directory.'/backup')
  call mkdir(g:vim_tmp_directory.'/backup')
endif
if !isdirectory(g:vim_tmp_directory.'/swap')
  call mkdir(g:vim_tmp_directory.'/swap')
endif
if !isdirectory(g:vim_tmp_directory.'/undo')
  call mkdir(g:vim_tmp_directory.'/undo')
endif

" Create backup files.
set backup
set nowritebackup
let &backupdir=g:vim_tmp_directory.'/backup'

" Create swap files.
set swapfile
" Set swapfile save directory.
let &directory=g:vim_tmp_directory.'/swap'

if v:version >= 703
  " Set undo file.
  set undofile
  let &undodir=&directory.'undo'
endif

" CursorHold time.
" If 2.5sec stop cursor then save swapfile.
set updatetime=2500

" Keymapping timeout.
set timeout timeoutlen=750 ttimeoutlen=200

" Enable backspace delete indent and newline.
set backspace=indent,eol,start

" Use clipboard register.
set clipboard& clipboard+=unnamed

" Auto read if file is changed.
set autoread

" Substitue <tab> with blanks.
set tabstop=2
" Spaces instead <tab>.
set softtabstop=2
"Autoindent width.
set shiftwidth=2
" "Round indent by shiftwidth.
set shiftround

" Smart insert tab setting.
set smarttab

" Exchange tab to spaces.
set expandtab

" Enable modeline.
set modeline

" Enable folding.
set foldenable
" Syntax highlighting items specify folds.
set foldmethod=syntax
" Always start editing with all no folds closed.
set foldlevelstart=99
" Show folding level.
set foldcolumn=1

" Use vimgrep.
set grepprg=internal
" Use grep.
" set grepprg=grep\ -nH
" default-mac: grep -n $* /dev/null
" default-win: findstr /n

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

" Show line number.
set number
set numberwidth=4
" Show ruler.
set ruler

" Wrap long line.
set wrap
set whichwrap+=h,l,<,>,[,],b,s
" Disable auto break long line.
set textwidth=0
set sidescroll=0
" Turn down a long line appointed in 'braket' (if wrap/nolist then effective)
set linebreak
set showbreak=>\ 
set breakat=\ \>;:,!

" Show <tab> and <space>(trailing)
set list
set listchars=tab:>-,trail:_

" Highlight parenthesis.
set showmatch
" Highlight <>.
set matchpairs+=<:>
" Highlight when CursorMoved.
set cpoptions-=m
set matchtime=3
" Highlighted columns.
set colorcolumn=0

" Always display statusline.
set laststatus=2
" Height of command line.
set cmdheight=2
" Show command on statusline.
set showcmd

" Show title.
set title
" Title length.
set titlelen=100
" Title string.
if s:iswin
  set titlestring=%<%F\ -\ Vim " %{expand("%:p:.")} \ [%{getfperm(expand('$p'))}]\ %<\ -\ Vim
else
  let &titlestring="%{expand('%:p:.')}%(%m%r%w%) [%{getfperm(expand('%p'))}] %< - Vim"
endif

" Show always tabline.
set showtabline=2
" Set tabpage max.
set tabpagemax=10

" Adjust window size of preview and help.
set previewheight=5
set helpheight=15

" Display all the information of the tag by the supplement of the Insert mode.
set showfulltag

" Display candidate supplement.
set wildmenu
set wildmode=list:longest,list
" Can supplement a tag in a command-line.
set wildoptions=tagfile

" Show always vertical 5 lines for cursor.
set scrolloff=5

" Completion setting.
set completeopt=menuone,preview
" Complete from tag, include file, other buffer.
set complete=.,t,i,w,b,u
" Set popup menu max height.
set pumheight=20

" Splitting a window will put the new window right the current one.
set splitright
" Splitting a window will put the new window below the current one.
set splitbelow
" No equal windows size.
set noequalalways

" Set maximam command line window.
set cmdwinheight=5

" When a line is long, do not omit it in @.
set display=lastline

" Put cursor on non-whitespace in case of moved line.
set startofline

" Enable spell check.
set nospell spelllang=en_us

" Disable bell.
set visualbell
set vb t_vb=

" Explicitly tell vim that the terminal supports 256 colors
set t_Co=256

" Report changes.
set report=0

" Don't redraw while macro executing.
set lazyredraw

" }}}1
"===============================================================================

"===============================================================================
" Syntax: "{{{1

" Enable syntax color.
syntax enable

" Enable smart indent.
set autoindent
set smartindent

" }}}1
"===============================================================================

"===============================================================================
" Plugin: "{{{1

" }}}1
"===============================================================================

"===============================================================================
" Key Mapping: "{{{1

nnoremap <space> :
vnoremap <space> :

inoremap <c-f> <esc>

cmap <c-h> <left>
cmap <c-l> <right>
cmap <c-e> <end>
cmap <c-a> <home>

nnoremap vv <c-v>

nnoremap M `

" Fix Current buffer indent.
nnoremap <Tab>= ggvG=2<C-o>

" Switch buffer.
nnoremap <C-q> <C-^>

" Switch wrap.
nnoremap <silent>,tw
      \ :<C-u>setlocal wrap!
      \ \|    setlocal wrap?<CR>

if exists('$MYVIMRC')
  nnoremap <silent> ,v :<C-u>e $MYVIMRC<CR>
  nnoremap ,V :<C-u>source $MYVIMRC<CR>
endif
if exists('$MYGVIMRC')
  nnoremap <silent> ,gv :<C-u>e $MYGVIMRC<CR>
  nnoremap ,gV :<C-u>source $MYGVIMRC<CR>
endif

" Change current window and size.
nnoremap <silent> <C-e>h <c-w>h:call GoodWinWidth()<cr>
nnoremap <silent> <C-e>j <c-w>j:call GoodWinHeight()<cr>
nnoremap <silent> <C-e>k <c-w>k:call GoodWinHeight()<cr>
nnoremap <silent> <C-e>l <c-w>l:call GoodWinWidth()<cr>

nnoremap <silent> <C-e>eu :<C-u>set fenc=utf-8<CR>
nnoremap <silent> <C-e>ee :<C-u>set fenc=euc-jp<CR>
nnoremap <silent> <C-e>es :<C-u>set fenc=cp932<CR>
nnoremap <silent> <C-e>eU :<C-u>e ++enc=utf-8 %<CR>
nnoremap <silent> <C-e>eE :<C-u>e ++enc=euc-jp %<CR>
nnoremap <silent> <C-e>eS :<C-u>e ++enc=cp932 %<CR>

nnoremap <silent> <C-e>el :<C-u>set fileformat=unix<CR>
nnoremap <silent> <C-e>em :<C-u>set fileformat=mac<CR>
nnoremap <silent> <C-e>ed :<C-u>set fileformat=dos<CR>
nnoremap <silent> <C-e>eL :<C-u>e ++fileformat=unix %<CR>
nnoremap <silent> <C-e>eM :<C-u>e ++fileformat=mac %<CR>
nnoremap <silent> <C-e>eD :<C-u>e ++fileformat=dos %<CR>

nnoremap <silent> <C-e>fm :<C-u>set foldmethod=marker<CR>
nnoremap <silent> <C-e>fi :<C-u>set foldmethod=indent<CR>
nnoremap <silent> <C-e>fs :<C-u>set foldmethod=syntax<CR>

nnoremap <silent> <C-e>cc :<C-u>let &colorcolumn = &colorcolumn == 0 ? 80 : 0<CR>

" }}}1
"===============================================================================

"===============================================================================
" Function: "{{{1

"-------------------------------------------------------------------------------
" WindowResize: "{{{2

function! GoodWinWidth()
  let s:w = float2nr((2.0 / 3.0) * &columns)
  if winwidth(0) < s:w
    execute "vertical resize " . s:w
  endif
  unlet s:w
endfunction

function! GoodWinHeight()
  let s:h = float2nr((2.0 / 3.0) * &lines)
  if winheight(0) < s:h
    execute "botright resize " . s:h
  endif
  unlet s:h
endfunction

" }}}2
"-------------------------------------------------------------------------------

" }}}1
"===============================================================================

"===============================================================================
" Platform: "{{{1

" }}}1
"===============================================================================

"===============================================================================
" Other: "{{{1

" }}}1
"===============================================================================

" vim: foldmethod=marker
