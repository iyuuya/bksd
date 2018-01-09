"===============================================================================
" Note: "{{{1
" .vimrc
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

" sudoの場合は設定を読み込まない
if exists('$SUDO_USER')
  finish
endif

"===============================================================================
" Initialize: "{{{1

"-------------------------------------------------------------------------------
" Initialize Options: "{{{2

" Enable no Vi compatible commands.
if &compatible && has('vim_starting')
  set nocompatible
endif

let g:python_host_prog = expand('~/.anyenv/envs/pyenv/versions/neovim2/bin/python')
let g:python3_host_prog = expand('~/.anyenv/envs/pyenv/versions/neovim3/bin/python')

let $MYVIMFILES = expand('~/.config/vim')
execute 'set runtimepath^=' . $MYVIMFILES

if my#iswin()
  language message en
else
  language message C
endif
language ctype C
language time C

let g:mapleader = ','
let g:maplocalleader = 'm'

nnoremap <LocalLeader> <Nop>
xnoremap <LocalLeader> <Nop>
nnoremap <leader> <Nop>
xnoremap <leader> <Nop>

" tmp directory.
if !exists('g:vim_tmp_directory')
  let g:vim_tmp_directory = $MYVIMFILES . '/tmp'
endif

" Create tmp directory.
call my#mkdir_p(g:vim_tmp_directory)

" environment variables.
if !exists('$MYVIMRC')
  let $MYVIMRC = expand($HOME . '/.vimrc')
endif
if !exists('$MYGVIMRC')
  let $MYGVIMRC = expand($HOME . '/.gvimrc')
endif

augroup MyAutoCmd
  autocmd!
augroup END

" }}}2
"-------------------------------------------------------------------------------

filetype indent plugin on

" }}}1
"===============================================================================

"===============================================================================
" Encoding: "{{{1

" The automatic recognition of the character code.

" Setting of the encoding to use for a save and reading.
" Make it normal in UTF-8 in Unix.
if has('vim_starting')
  set encoding=utf-8
endif

" Setting of terminal encoding."{{{
if !has('gui_running')
  if &term ==# 'win32' &&
        \ (v:version < 703 || (v:version == 703 && has('patch814')))
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
elseif my#iswin()
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
    let &fileencodings .= ',' . 'ucs-2le'
    let &fileencodings .= ',' . 'ucs-2'
  endif
  let &fileencodings .= ',' . s:enc_jis
  let &fileencodings .= ',' . 'utf-8'

  if &encoding ==# 'utf-8'
    let &fileencodings .= ',' . s:enc_euc
    let &fileencodings .= ',' . 'cp932'
  elseif &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    let &encoding = s:enc_euc
    let &fileencodings .= ',' . 'cp932'
    let &fileencodings .= ',' . &encoding
  else  " cp932
    let &fileencodings .= ',' . s:enc_euc
    let &fileencodings .= ',' . &encoding
  endif
  let &fileencodings .= ',' . 'cp20932'

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
function! s:ReCheck_FENC() abort "{{{
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

" Command group opening with a specific character code again."{{{
" In particular effective when I am garbled in a terminal.
" Open in UTF-8 again.
command! -bang -bar -complete=file -nargs=? Utf8
      \ edit<bang> ++enc=utf-8 <args>
" Open in iso-2022-jp again.
command! -bang -bar -complete=file -nargs=? Iso2022jp
      \ edit<bang> ++enc=iso-2022-jp <args>
" Open in Shift_JIS again.
command! -bang -bar -complete=file -nargs=? Cp932
      \ edit<bang> ++enc=cp932 <args>
" Open in EUC-jp again.
command! -bang -bar -complete=file -nargs=? Euc
      \ edit<bang> ++enc=euc-jp <args>
" Open in UTF-16 again.
command! -bang -bar -complete=file -nargs=? Utf16
      \ edit<bang> ++enc=ucs-2le <args>
" Open in UTF-16BE again.
command! -bang -bar -complete=file -nargs=? Utf16be
      \ edit<bang> ++enc=ucs-2 <args>

" Aliases.
command! -bang -bar -complete=file -nargs=? Jis  Iso2022jp<bang> <args>
command! -bang -bar -complete=file -nargs=? Sjis  Cp932<bang> <args>
command! -bang -bar -complete=file -nargs=? Unicode Utf16<bang> <args>
"}}}

" Tried to make a file note version."{{{
" Don't save it because dangerous.
command! WUtf8 setlocal fenc=utf-8
command! WIso2022jp setlocal fenc=iso-2022-jp
command! WCp932 setlocal fenc=cp932
command! WEuc setlocal fenc=euc-jp
command! WUtf16 setlocal fenc=ucs-2le
command! WUtf16be setlocal fenc=ucs-2
" Aliases.
command! WJis  WIso2022jp
command! WSjis  WCp932
command! WUnicode WUtf16
"}}}

" Appoint a line feed."{{{
command! -bang -complete=file -nargs=? WUnix
      \ write<bang> ++fileformat=unix <args> | edit <args>
command! -bang -complete=file -nargs=? WDos
      \ write<bang> ++fileformat=dos <args> | edit <args>
command! -bang -complete=file -nargs=? WMac
      \ write<bang> ++fileformat=mac <args> | edit <args>
"}}}

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

call my#mkdir_p(g:vim_tmp_directory.'/backup')
call my#mkdir_p(g:vim_tmp_directory.'/swap')
call my#mkdir_p(g:vim_tmp_directory.'/undo')

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
  let &undodir=g:vim_tmp_directory.'/undo'
endif

" CursorHold time.
" If 2.5sec stop cursor then save swapfile.
set updatetime=200

" Keymapping timeout.
set timeout timeoutlen=750 ttimeoutlen=0

" Enable backspace delete indent and newline.
set backspace=indent,eol,start

" Use clipboard register.
set clipboard& clipboard+=unnamed
if has('gui')
  set clipboard+=autoselect
endif

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
" Always start editing with all no folds closed.
set foldlevelstart=99
" Show folding level.
set foldcolumn=1
" Syntax highlighting items specify folds.
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

" Use vimgrep.
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

" Show line number.
set number
set numberwidth=4
set norelativenumber
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
set listchars=tab:>-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

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

let &statusline="%<%f%=%m%r%w%y[%{(&fenc!=''?&fenc:&enc)}][%{&ff}][%04l:%03v/%p%%]"

" Show title.
set title
" Title length.
set titlelen=100
" Title string.
if my#iswin()
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

set cursorline
augroup MyCursorColumnGrp
  autocmd!
  autocmd FileType yaml setlocal cursorcolumn
augroup END

augroup CppColorColumnGrp
  autocmd!
  autocmd FileType cpp setlocal colorcolumn=120
augroup END

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

set conceallevel=0
set concealcursor=

" }}}1
"===============================================================================

"===============================================================================
" Syntax: "{{{1

" Enable smart indent.
set autoindent
set smartindent

set synmaxcol=200

autocmd MyAutoCmd Syntax * if 10000 < line('$') | syntax sync minlines=100 | set foldmethod=indent | endif
autocmd MyAutoCmd VimEnter,ColorScheme * call <SID>AfterColors()

function! <SID>AfterColors()
  if exists('g:colors_name') && strlen(g:colors_name)
    execute 'runtime! after/colors/' . g:colors_name . '.vim'
  endif
endfunction

" }}}1
"===============================================================================

" Types: "{{{1

function! <SID>EnableJavascript()
  let g:used_javascript_libs = 'jquery,underscore,react,flux,jasmine,d3'
  let b:javascript_lib_use_jquery = 1
  let b:javascript_lib_use_underscore = 1
  let b:javascript_lib_use_react = 1
  let b:javascript_lib_use_flux = 1
  let b:javascript_lib_use_jasmine = 1
  let b:javascript_lib_use_d3 = 1
endfunction

function! <SID>SetIndentForRuby()
  " let g:ruby_indent_access_modifier_style = 'indent'
  setlocal smartindent autoindent
  setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
endfunction

function! <SID>EnableFish()
  compiler fish
  setlocal textwidth=79
  setlocal foldmethod=expr
endfunction

augroup MyFileTypes
  autocmd!
  autocmd BufRead,BufNew *.arb setlocal filetype=ruby
  autocmd BufRead,BufNew *.apib setlocal filetype=apiblueprint
  autocmd BufRead,BufNew *.ts setlocal filetype=typescript
  autocmd BufRead,BufNew *.vue setlocal filetype=html

	autocmd BufRead,BufNew *.go setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufRead,BufNew *.fish setlocal filetype=fish

  autocmd FileType javascript,javascript.jsx call <SID>EnableJavascript()
  autocmd FileType ruby call <SID>SetIndentForRuby()
  autocmd FileType fish call <SID>EnableFish()
augroup END

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

" 雑: GetPageTitle('http://hoge.com/fuga')
" 雑: i<C-r>=GetPageTitle(@*)
function! GetPageTitle(url)
  return system('curl --silent ' . a:url . " | grep '<title>' | sed -e 's/\\<title\\>//g' | sed -e 's/\\<\\/title\\>//g' | sed -e 's/ *$//g' | sed -e 's/^ *//g' | sed -e 's/\\n$//g'")
endfunction

" Jimakun
function! Jimakun(subtitle)
  call system('jimakun "' . a:subtitle . '" &')
endfunction
command! -nargs=1 Jimakun call Jimakun(<f-args>)

" goto center(width)
function! GotoCenter()
  call cursor(0, strlen(getline('.')) / 2)
endfunction

function! GotoHalfLine()
  let s:number = execute '%s/^//n'
  let s:line_number = matchstr(s:number,'^[0-9][0-9][0-9]\|[0-9][0-9]\|[0-9]')
  call line('$')
endfunction

" }}}1
"===============================================================================

"===============================================================================
" Command: "{{{1

command! -nargs=0 Bdall :%bd!

" }}}1
"===============================================================================

"===============================================================================
" Key Mapping: "{{{1

nnoremap <space> :
vnoremap <space> :

inoremap <c-f> <esc>
inoremap <expr> j  getline('.')[col('.') - 2] ==# 'j' ? "\<BS>\<ESC>" : 'j'

cmap <c-h> <left>
cmap <c-l> <right>
cmap <c-e> <end>
cmap <c-a> <home>

nnoremap M `
" Fix Current buffer indent.
nnoremap <Tab>= ggvG=2<C-o>

" Switch buffer.
nnoremap <C-q> <C-^>

" Continuously increment/decrement
vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv

nnoremap [mybind] Nop
nmap <C-e> [mybind]

" Switch wrap.
nnoremap <silent> [mybind]tw :<C-u>setlocal wrap! wrap?<CR>

if exists('$MYVIMRC')
  nnoremap <silent> [mybind]v :<C-u>e $MYVIMRC<CR>
  nnoremap [mybind]V :<C-u>source $MYVIMRC<CR>
endif
if exists('$MYGVIMRC')
  nnoremap <silent> [mybind]gv :<C-u>e $MYGVIMRC<CR>
  nnoremap [mybind]gV :<C-u>source $MYGVIMRC<CR>
endif

" Change current window and size.
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

nnoremap <silent> gm :call GotoCenter()<CR>

" }}}1
"===============================================================================

"===============================================================================
" Platform: "{{{1

if my#iswin()
  set shell=bash
else
  if &shell =~# 'fish$'
    set shell=sh
  else
    set shell=zsh
  endif
endif

" }}}1
"===============================================================================

" Enable syntax color.
syntax on

" Disable mouse support.
set mouse=

" Use Japanese or English help.
" 真のVimmerはen
set helplang& helplang=ja,en

set termguicolors
colorscheme iceberg

set secure

augroup vimrc-local
  autocmd!
  autocmd VimEnter * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let l:files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(l:files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

" vim: foldmethod=marker tabstop=2 softtabstop=2 shiftwidth=2 expandtab
