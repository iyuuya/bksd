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
if has('vim_starting')
  set nocompatible
endif

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

nnoremap <LocalLeader> <Nop>
xnoremap <LocalLeader> <Nop>
nnoremap <leader> <Nop>
xnoremap <leader> <Nop>

" if s:iswin
"   set shellslash
" endif

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
  let s:bundle_path = expand($MYVIMFILES . '/bundle')
  let s:neobundle_path = expand(s:bundle_path . '/neobundle.vim')
  execute 'set runtimepath+=' . s:neobundle_path

  if !isdirectory(s:neobundle_path)
    call system('git clone https://github.com/Shougo/neobundle.vim.git ' . s:neobundle_path)
  endif

  call neobundle#begin(s:bundle_path)
  let s:vimfile_path = expand($MYVIMFILES . '/Vimfile')
  if filereadable(s:vimfile_path)
    execute 'source ' . s:vimfile_path
  endif
  unlet s:vimfile_path
  call neobundle#end()
  unlet s:bundle_path
  unlet s:neobundle_path

  NeoBundleCheck
endif

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
    let &fileencodings .= ',' . 'ucs-2le'
    let &fileencodings .= ',' . 'ucs-2'
  endif
  let &fileencodings .= ',' . s:enc_jis

  if &encoding ==# 'utf-8'
    let &fileencodings .= ',' . s:enc_euc
    let &fileencodings .= ',' . 'cp932'
  elseif &encoding =~# '^euc-\%(jp\|jisx0213\)$'
    let &encoding = s:enc_euc
    let &fileencodings .= ',' . 'utf-8'
    let &fileencodings .= ',' . 'cp932'
  else  " cp932
    let &fileencodings .= ',' . 'utf-8'
    let &fileencodings .= ',' . s:enc_euc
  endif
  let &fileencodings .= ',' . &encoding

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

if !exists('vimpager')
  " Default fileformat.
  set fileformat=unix
endif
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
  let &undodir=g:vim_tmp_directory.'/undo'
endif

" CursorHold time.
" If 2.5sec stop cursor then save swapfile.
set updatetime=200

" Keymapping timeout.
set timeout timeoutlen=750 ttimeoutlen=200

" Enable backspace delete indent and newline.
set backspace=indent,eol,start

" Use clipboard register.
set clipboard& clipboard+=unnamed
set clipboard+=autoselect

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
  autocmd FileType yaml setlocal foldmethod=indent
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

set cursorline
augroup MyCursorColumnGrp
  autocmd!
  autocmd FileType yaml setlocal cursorcolumn
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

" }}}1
"===============================================================================

"===============================================================================
" Syntax: "{{{1

" Enable smart indent.
set autoindent
set smartindent

augroup MyArbGrp
  autocmd!
  autocmd BufEnter,BufRead,BufNew *.arb setlocal filetype=ruby
augroup END

" }}}1
"===============================================================================

"===============================================================================
" Plugins: "{{{1

"-------------------------------------------------------------------------------
" Unite: "{{{2

if neobundle#is_installed('unite.vim')
  let g:unite_enable_start_insert = 0
  let g:unite_enable_split_vertically = 0
  let g:unite_source_history_yank_enable = 1
  let g:unite_matcher_fuzzy_max_input_length = 30
  let g:unite_source_find_max_candidates = 200
  let g:unite_data_directory = g:vim_tmp_directory."/unite"

  " unite grep に ag(The Silver Searcher) を使う
  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
  endif

  nnoremap <S-Space> :<C-u>Unite -start-insert source<CR>
  " unite.vim
  nnoremap [unite] <nop>
  nmap <C-c> [unite]
  nnoremap [unite]   :<C-u>Unite<Space>
  nnoremap [unite]uf :<C-u>Unite -start-insert buffer file_rec/async<CR>
  nnoremap [unite]ub :<C-u>Unite bookmark<CR>
  nnoremap [unite]us :<C-u>Unite source<CR>
  nnoremap [unite]ui :<C-u>Unite find<CR>
  nnoremap [unite]un :<C-u>Unite function<CR>
  nnoremap [unite]uy :<C-u>Unite history/yank<CR>
  nnoremap [unite]ug :<C-u>Unite grep<CR>
  nnoremap [unite]uj :<C-u>Unite -start-insert jump<CR>
  nnoremap [unite]uc :<C-u>Unite -start-insert launcher<CR>
  nnoremap [unite]ul :<C-u>Unite -start-insert line<CR>
  nnoremap [unite]uk :<C-u>Unite -start-insert mapping<CR>
  nnoremap [unite]uo :<C-u>Unite output<CR>
  nnoremap [unite]ur :<C-u>Unite -start-insert register<CR>
  nnoremap [unite]up :<C-u>Unite -start-insert -no-split process<CR>
  nnoremap [unite]ut :<C-u>Unite tab<CR>
  nnoremap [unite]uu :<C-u>Unite undo<CR>
  nnoremap [unite]uw :<C-u>Unite window<CR>
  " unite-help
  nnoremap [unite]uh :<C-u>Unite help<CR>
  " unite-snippet
  nnoremap [unite]pt :<C-u>Unite snippet<CR>
  " neobundle.vim
  nnoremap [unite]n  :<C-u>Unite neobundle<CR>
  nnoremap [unite]ni :<C-u>Unite neobundle/install<CR>
  nnoremap [unite]na :<C-u>Unite neobundle/lazy<CR>
  nnoremap [unite]nl :<C-u>Unite neobundle/log<CR>
  nnoremap [unite]ns :<C-u>Unite neobundle/search<CR>
  nnoremap [unite]nu :<C-u>Unite neobundle/update<CR>
  " unite-outline
  nnoremap [unite]o  :<C-u>Unite -vertical -winwidth=36 outline<CR>
  " unite-rake
  nnoremap [unite]rk :<C-u>Unite rake<CR>
  " unite-rails
  nnoremap [unite]rf :<C-u>Unite -start-insert rails/config<CR>
  nnoremap [unite]rc :<C-u>Unite -start-insert rails/controller<CR>
  nnoremap [unite]rdb :<C-u>Unite -start-insert rails/db<CR>
  nnoremap [unite]ry :<C-u>Unite -start-insert rails/destroy<CR>
  nnoremap [unite]rg :<C-u>Unite -start-insert rails/generate<CR>
  nnoremap [unite]rh :<C-u>Unite -start-insert rails/helper<CR>
  nnoremap [unite]ri :<C-u>Unite -start-insert rails/initializer<CR>
  nnoremap [unite]rj :<C-u>Unite -start-insert rails/javascript<CR>
  nnoremap [unite]rl :<C-u>Unite -start-insert rails/lib<CR>
  nnoremap [unite]ro :<C-u>Unite -start-insert rails/log<CR>
  nnoremap [unite]ra :<C-u>Unite -start-insert rails/mailer<CR>
  nnoremap [unite]rm :<C-u>Unite -start-insert rails/model<CR>
  nnoremap [unite]rr :<C-u>Unite -start-insert rails/route<CR>
  nnoremap [unite]rp :<C-u>Unite -start-insert rails/spec<CR>
  nnoremap [unite]rs :<C-u>Unite -start-insert rails/stylesheet<CR>
  nnoremap [unite]rv :<C-u>Unite -start-insert rails/view<CR>
  nnoremap [unite]rde :<C-u>Unite -start-insert file:app/decorators<CR>
  nnoremap [unite]rad :<C-u>Unite -start-insert file:app/admin<CR>
  " Dictionaries
  nnoremap [unite]dw :<C-u>Unite webcolornane<CR>
  nnoremap [unite]dh :<C-u>Unite httpstatus<CR>
  " unite-giti
  nnoremap [unite]g  :<C-u>Unite giti<CR>
  nnoremap [unite]gb :<C-u>Unite giti/branch_all<CR>
  nnoremap [unite]gl :<C-u>Unite giti/log<CR>
  nnoremap [unite]gr :<C-u>Unite giti/remote<CR>
  nnoremap [unite]gs :<C-u>Unite giti/status<CR>
  " unite-colorscheme
  command! ColorScheme :Unite -auto-preview colorscheme
  " unite-tag
  nnoremap [unite]t  :<C-u>Unite tag<CR>
  nnoremap [unite]tf :<C-u>Unite tag/file<CR>
  nnoremap [unite]ti :<C-u>Unite tag/include<CR>
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" VimShell: "{{{2

if neobundle#is_installed('vimshell.vim')
  let g:vimshell_interactive_update_time = 10
  let g:vimshell_temporary_directory = g:vim_tmp_directory."/vimshell"
  let g:vimshell_max_command_history = 10000
  " if s:ismac
  "   let g:vimshell_editor_command = system('readlink ~/Applications/MacVim.app') . '/Contents/MacOS/MacVim'
  " endif

  let g:vimshell_prompt = '% '
  let g:vimshell_user_prompt = "$USER.'@'.hostname().'('.strftime('%Y/%m/%d %H:%M:%S').')>>'"
  let g:vimshell_secondary_prompt = '> '
  let g:vimshell_right_prompt = "'['.fnamemodify(getcwd(), ':~').']'"

  " augroup MyVimShellGrp
  "   autocmd FileType vimshell call vimshell#hook#add('chpwd', 'my_chpwd', 'g:my_chpwd')
  " augroup END

  " function! g:my_chpwd(args, context)
  "   call vimshell#execute('ls')
  " endfunction

  nnoremap ; :VimShellCurrentDir<CR>
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" VimFiler: "{{{2

if neobundle#is_installed('vimfiler.vim')
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_safe_mode_by_default = 0
  let g:vimfiler_data_directory = g:vim_tmp_directory.'/vimfiler'
  nnoremap : :VimFilerBufferDir -split -simple -no-quit -winwidth=32<CR>
  nnoremap ,vf :VimFilerDouble<CR>
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" NeoComplete: "{{{2

if neobundle#is_installed('neocomplete.vim')
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#max_list = 100
  let g:neocomplete#max_keyword_width = 40
  let g:neocomplete#auto_completion_start_length = 2
  let g:neocomplete#manual_completion_start_length = 1
  let g:neocomplete#min_keyword_length = 3
  let g:neocomplete#enable_ignore_case = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
  let g:neocomplete#data_directory = g:vim_tmp_directory."/neocomplete"

  nnoremap <Leader>ne :<C-u>NeoCompleteEnable<CR>
  nnoremap <Leader>nd :<C-u>NeoCompleteDisable<CR>
  nnoremap <Leader>nt :<C-u>NeoCompleteToggle<CR>

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplete#undo_completion()
  inoremap <expr><C-l>     neocomplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplete#close_popup()
  inoremap <expr><C-e>  neocomplete#cancel_popup()
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

  " For cursor moving in insert mode(Not recommended)
  "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
  "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
  "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
  "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
  " Or set this.
  "let g:neocomplete#enable_cursor_hold_i = 1
  " Or set this.
  "let g:neocomplete#enable_insert_char_pre = 1

  " AutoComplPop like behavior.
  "let g:neocomplete#enable_auto_select = 1

  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:neocomplete#enable_auto_select = 1
  "let g:neocomplete#disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

  let g:neocomplete#sources#include#paths = {
        \   'cpp' : '.,C:/MinGW/lib/gcc/mingw32/4.8.1/include,C:/MinGW/lib/gcc/mingw32/4.8.1/include/c++,C:/Program\ Files\ (x86)/Microsoft\ DirectX\ SDK\ (June\ 2010)/Include,C:/Program\ Files\ (x86)/Microsoft\ SDKs/Windows/v7.1A/Include',
        \   'c' : '.,C:/MinGW/lib/gcc/mingw32/4.8.1/include,C:/MinGW/lib/gcc/mingw32/4.8.1/include/c++,C:/Program\ Files\ (x86)/Microsoft\ DirectX\ SDK\ (June\ 2010)/Include,C:/Program\ Files\ (x86)/Microsoft\ SDKs/Windows/v7.1A/Include',
        \ }

  let g:neocomplete#sources#include#patterns = {
        \ 'cpp':  '^\s*#\s*include',
        \ 'c':    '^\s*#\s*include',
        \ 'ruby': '^\s*require',
        \ 'perl': '^\s*use',
        \ }
  "インクルード先のファイル名の解析パターン
  let g:neocomplete#sources#include#exprs = {
        \ 'ruby': substitute(v:fname,'::','/','g')
        \ }
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" NeoSnippet: "{{{2

if neobundle#is_installed('neosnippet.vim')
  let g:neosnippet#snippets_directory = $MYVIMFILES."/snippets"
  let g:neosnippet#enable_snipmate_compatibility = 1

  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)

  " SuperTab like snippets behavior.
  "imap <expr><C-TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  "smap <expr><C-TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=niv
  endif

  nnoremap <silent><Leader>nse :<C-u>NeoSnippetEdit -split<CR>

  augroup MyAutoCmd
    autocmd BufEnter,BufRead,BufNew app/views/*          NeoSnippetSource ~/.vim/snippets/ruby.rails.view.snip
    autocmd BufEnter,BufRead,BufNew app/controllers/*.rb NeoSnippetSource ~/.vim/snippets/ruby.rails.controller.snip
    autocmd BufEnter,BufRead,BufNew app/models/*.rb      NeoSnippetSource ~/.vim/snippets/ruby.rails.model.snip
    autocmd BufEnter,BufRead,BufNew app/db/migrate/*     NeoSnippetSource ~/.vim/snippets/ruby.rails.migrate.snip
    autocmd BufEnter,BufRead,BufNew app/config/routes.rb NeoSnippetSource ~/.vim/snippets/ruby.rails.route.snip
    autocmd BufEnter,BufRead,BufNew spec/**/*.rb         NeoSnippetSource ~/.vim/snippets/ruby.rails.rspec.snip
    " autocmd BufEnter,BufRead,BufNew spec/**/*.rb    NeoSnippetSource ~/.vim/snippets/ruby.rspec.snip
  augroup END
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Vim PowerLine: "{{{2

colorscheme Tomorrow-Night-Bright

if neobundle#is_installed('vim-powerline')
  let g:Powerline_symbols = 'fancy'

  let g:Powerline_colorscheme = 'default'

  let g:Powerline_mode_n = 'NR'
  let g:Powerline_mode_i = 'IN'
  let g:Powerline_mode_R = 'RE'
  let g:Powerline_mode_v = 'VI'
  let g:Powerline_mode_V = 'VL'
  let g:Powerline_mode_cv = 'VB'
  let g:Powerline_mode_s = 'SE'
  let g:Powerline_mode_S = 'SL'
  let g:Powerline_mode_cs = 'SB'
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Vim Airline: "{{{2

" if neobundle#is_installed('vim-airline')
"   let g:airline#extensions#tabline#enabled = 1
"   let g:airline#extensions#tabline#left_sep = ' '
"   let g:airline#extensions#tabline#left_alt_sep = '|'
" endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Switch: "{{{2

if neobundle#is_installed('switch.vim')
  function! s:separate_defenition_to_each_filetypes(ft_dictionary) "{{{
    let result = {}

    for [filetypes, value] in items(a:ft_dictionary)
      for ft in split(filetypes, ",")
        if !has_key(result, ft)
          let result[ft] = []
        endif

        call extend(result[ft], copy(value))
      endfor
    endfor

    return result
  endfunction "}}}

  nnoremap ! :Switch<CR>
  let s:switch_definition = {
        \ '*': [
        \   ['is', 'are']
        \ ],
        \ 'ruby,eruby,haml,arb' : [
        \   ['if', 'unless'],
        \   ['while', 'until'],
        \   ['.blank?', '.present?'],
        \   ['include', 'extend'],
        \   ['class', 'module'],
        \   ['.inject', '.delete_if'],
        \   ['.map', '.map!'],
        \   ['attr_accessor', 'attr_reader', 'attr_writer'],
        \ ],
        \ 'Gemfile,Berksfile' : [
        \   ['=', '<', '<=', '>', '>=', '~>'],
        \ ],
        \ 'ruby.application_template' : [
        \   ['yes?', 'no?'],
        \   ['lib', 'initializer', 'file', 'vendor', 'rakefile'],
        \   ['controller', 'model', 'view', 'migration', 'scaffold'],
        \ ],
        \ 'erb,html,php' : [
        \   { '<!--\([a-zA-Z0-9 /]\+\)--></\(div\|ul\|li\|a\)>' : '</\2><!--\1-->' },
        \ ],
        \ 'rails' : [
        \   [100, ':continue', ':information'],
        \   [101, ':switching_protocols'],
        \   [102, ':processing'],
        \   [200, ':ok', ':success'],
        \   [201, ':created'],
        \   [202, ':accepted'],
        \   [203, ':non_authoritative_information'],
        \   [204, ':no_content'],
        \   [205, ':reset_content'],
        \   [206, ':partial_content'],
        \   [207, ':multi_status'],
        \   [208, ':already_reported'],
        \   [226, ':im_used'],
        \   [300, ':multiple_choices'],
        \   [301, ':moved_permanently'],
        \   [302, ':found'],
        \   [303, ':see_other'],
        \   [304, ':not_modified'],
        \   [305, ':use_proxy'],
        \   [306, ':reserved'],
        \   [307, ':temporary_redirect'],
        \   [308, ':permanent_redirect'],
        \   [400, ':bad_request'],
        \   [401, ':unauthorized'],
        \   [402, ':payment_required'],
        \   [403, ':forbidden'],
        \   [404, ':not_found'],
        \   [405, ':method_not_allowed'],
        \   [406, ':not_acceptable'],
        \   [407, ':proxy_authentication_required'],
        \   [408, ':request_timeout'],
        \   [409, ':conflict'],
        \   [410, ':gone'],
        \   [411, ':length_required'],
        \   [412, ':precondition_failed'],
        \   [413, ':request_entity_too_large'],
        \   [414, ':request_uri_too_long'],
        \   [415, ':unsupported_media_type'],
        \   [416, ':requested_range_not_satisfiable'],
        \   [417, ':expectation_failed'],
        \   [422, ':unprocessable_entity'],
        \   [423, ':precondition_required'],
        \   [424, ':too_many_requests'],
        \   [426, ':request_header_fields_too_large'],
        \   [500, ':internal_server_error'],
        \   [501, ':not_implemented'],
        \   [502, ':bad_gateway'],
        \   [503, ':service_unavailable'],
        \   [504, ':gateway_timeout'],
        \   [505, ':http_version_not_supported'],
        \   [506, ':variant_also_negotiates'],
        \   [507, ':insufficient_storage'],
        \   [508, ':loop_detected'],
        \   [510, ':not_extended'],
        \   [511, ':network_authentication_required'],
        \ ],
        \ 'rspec': [
        \   ['describe', 'context', 'specific', 'example'],
        \   ['before', 'after'],
        \   ['be_true', 'be_false'],
        \   ['get', 'post', 'put', 'delete'],
        \   ['==', 'eql', 'equal'],
        \   { '\.should_not': '\.should' },
        \   ['\.to_not', '\.to'],
        \   { '\([^. ]\+\)\.should\(_not\|\)': 'expect(\1)\.to\2' },
        \   { 'expect(\([^. ]\+\))\.to\(_not\|\)': '\1.should\2' },
        \ ],
        \ 'markdown' : [
        \   ['[ ]', '[x]']
        \ ],
        \ }

  let s:switch_definition = s:separate_defenition_to_each_filetypes(s:switch_definition)
  function! s:define_switch_mappings() "{{{
    if exists('b:switch_custom_definitions')
      unlet b:switch_custom_definitions
    endif

    let dictionary = []
    for filetype in split(&ft, '\.')
      if has_key(s:switch_definition, filetype)
        let dictionary = extend(dictionary, s:switch_definition[filetype])
      endif
    endfor

    if exists('b:rails_root')
      let dictionary = extend(dictionary, s:switch_definition['rails'])
    endif

    if has_key(s:switch_definition, '*')
      let dictionary = extend(dictionary, s:switch_definition['*'])
    endif

    if !empty('dictionary')
      let gvn = 'b:switch_custom_definitions'
      if !exists(gvn)
        let cmd = 'let ' . gvn . ' = ' . string(dictionary)
        exe cmd
      endif
    endif
  endfunction"}}}

  augroup SwitchSetting
    autocmd!
    autocmd filetype * if !empty(split(&ft, '\.')) | call <SID>define_switch_mappings() | endif
  augroup END
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" AlpacaTags: "{{{2

if neobundle#is_installed('alpaca_tags')
  let g:alpaca_update_tags_config = {
        \ '_' : '-R --sort=yes --languages=-js,html,css',
        \ 'ruby': '--languages=+Ruby',
        \ }

  augroup AlpacaTags
    autocmd!
    if exists(':Tags')
      autocmd BufWritePost * TagsUpdate ruby
      autocmd BufWritePost Gemfile TagsBundle
      autocmd BufEnter * TagsSet
    endif
  augroup END

  nnoremap <expr>[unite]tt ':Unite tags -horizontal -buffer-name=tags -input='.expand("<cword>").'<CR>'
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Vim Ref: "{{{2

if neobundle#is_installed('vim-ref')
  let g:ref_open     = 'split'
  let g:ref_refe_cmd = 'refe'

  nnoremap [unite]rr :<C-U>Unite ref/refe -default-action=split -input=

  aug MyAutoCmd
    au FileType ruby,eruby,haml,ruby.rspec,arb nnoremap <silent><buffer>K  :<C-U>Unite -no-start-insert ref/refe -default-action=split -input=<C-R><C-W><CR>
  aug END
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" QuickRun: "{{{2

if neobundle#is_installed('vim-quickrun')
  let g:quickrun_config = get(g:, 'quickrun_config', {})
  let g:quickrun_config["dot/plantuml"] = {
        \   "command" : "plantuml",
        \   "exec" : "%c %o %s:p",
        \   "cmdopt"  : "-tutxt",
        \ }
  let g:quickrun_config.cpp = {
        \   'command' : 'clang++',
        \   'cmdopt' : '-std=c++1y -Wall -Wextra',
        \   'hook/quickrunex/enable' : 1,
        \ }
  let g:quickrun_config['cpp/gcc'] = {
        \   'command' : 'g++',
        \   'cmdopt' : '-std=c++11 -Wall -Wextra',
        \ }

  if neobundle#is_installed('vim-watchdogs')
    let g:watchdogs_check_BufWritePost_enable = 1
    " let g:quickrun_config['ruby/watchdogs_checker']    = { "type" : "watchdogs_checker/rubocop" }
    let g:quickrun_config["cpp/watchdogs_checker"]     = { "type" : "watchdogs_checker/clang++" }
    let g:quickrun_config["watchdogs_checker/g++"]     = { "cmdopt" : "-Wall" }
    let g:quickrun_config["watchdogs_checker/clang++"] = { "cmdopt" : "-Wall" }
  endif
endif

" }}}2
"-------------------------------------------------------------------------------
"
"-------------------------------------------------------------------------------
" VimOver: "{{{2

if neobundle#is_installed('vim-over')
  nnoremap <silent> <Leader><Space> :OverCommandLine<CR>
  vnoremap <silent> <Leader><Space> :OverCommandLine<CR>
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Vim Splash: "{{{2

let g:splash#path = g:vim_tmp_directory . '/vim_info.txt'

if !filereadable(g:splash#path)
  call system('curl -o ' . g:splash#path . ' https://gist.github.com/OrgaChem/7630711/raw/c90299e0aaa0cea8cd05a6ceb2e70074186f8ce5/vim_intro.txt')
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Previm: "{{{2

let g:previm_open_cmd = 'open -a "Google Chrome"'
" let g:previm_open_cmd = 'open -a Safari'

augroup MyTextileGrp
  autocmd BufEnter,BufRead,BufNew *.textile setlocal filetype=textile
augroup END

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Syntastic: "{{{2

if neobundle#is_installed('syntastic')
  let g:syntastic_mode_map = {
        \ 'mode': 'active',
        \ 'active_filetypes': ['ruby']
        \ }
  let g:syntastic_ruby_checkers = ['rubocop']
  let g:syntastic_ruby_rubocop_exec = $HOME . "/.anyenv/envs/rbenv/shims/rubocop"

  let g:syntastic_ruby_mri_exec = $HOME . '.anyenv/env/rbenv/shims/ruby'
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Rubocop: "{{{2

if neobundle#is_installed('vim-rubocop')
  let g:vimrubocop_config = './.rubocop.yml'
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Gista: "{{{2

let g:gista#github_user = 'iyuuya'
let g:gista#directory = g:vim_tmp_directory . '/gista/'
let g:gista#update_on_write = 1

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" TmuxNavigator: "{{{2

if neobundle#is_installed('vim-tmux-navigator')
  let g:tmux_navigator_no_mappings = 1

  nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
  nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
  nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
  nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
  command! Tvs :call system('tmux split-window')
  command! Tsp :call system('tmux split-window -h')
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Caw: "{{{2

if neobundle#is_installed('caw.vim')
  nmap <Leader>c <Plug>(caw:i:toggle)
  vmap <Leader>c <Plug>(caw:i:toggle)
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Marching: "{{{2

if neobundle#is_installed('vim-marching')
  let g:marching_clang_command = 'clang'
  let g:marching#clang_command#options = {
        \ 'cpp' : '-std=c++1y'
        \ }

  if s:ismac
    let g:marching_include_paths = [
          \ system("echo -n $(brew --prefix gcc)/include/c++/4.9.2"),
          \ system("echo -n $(brew --prefix boost)/include"),
          \ '/usr/include',
          \ system("echo -n $(brew --prefix)/include"),
          \ ]
  elseif s:iswin
    let g:marching_include_paths = [
          \ 'C:/MinGW/lib/gcc/mingw32/4.8.1/include',
          \ 'C:/MinGW/lib/gcc/mingw32/4.8.1/include/c++',
          \ 'C:/Program\ Files\ (x86)/Microsoft\ DirectX\ SDK\ (June\ 2010)/Include',
          \ 'C:/Program\ Files\ (x86)/Microsoft\ SDKs/Windows/v7.1A/Include',
          \ ]
  endif

  augroup CppPath
    autocmd!
    autocmd FileType cpp let &l:path=join(g:marching_include_paths,',')
  augroup END

  let g:marching_enable_neocomplete = 1

  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif

  let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" ESKK: "{{{2

if neobundle#is_installed('eskk.vim')
  let g:eskk#server = { 'host' : 'localhost', 'port' : 55100 }
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DBExt: "{{{2

if neobundle#is_installed('dbext.vim')
  nnoremap <Leader>sb :'<,'>DBExecVisualSQL<CR>
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Ag: "{{{2

if neobundle#is_installed('ag.vim')
  let g:agprg="ag --column"
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Tags: "{{{2

if neobundle#is_installed('vim-tags')
  let g:vim_tags_auto_generate = 0
  let g:vim_tags_project_tags_command = "ctags -f tags -R . 2>/dev/null"
  let g:vim_tags_gems_tags_command = "ctags -R -f Gemfile.lock.tags `bundle show --paths` 2>/dev/null"
  set tags+=tags,Gemfile.lock.tags
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" tmp: "{{{2

" }}}2
"-------------------------------------------------------------------------------

" }}}1
"===============================================================================

"===============================================================================
" Key Mapping: "{{{1

nnoremap <space> :
vnoremap <space> :

" inoremap <c-f> <esc>

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
nnoremap <silent><C-e>tw :<C-u>setlocal wrap! wrap?<CR>

nnoremap [mybind] Nop
nmap <C-e> [mybind]

if exists('$MYVIMRC')
  nnoremap <silent> [mybind]v :<C-u>e $MYVIMRC<CR>
  nnoremap [mybind]V :<C-u>source $MYVIMRC<CR>
endif
if exists('$MYGVIMRC')
  nnoremap <silent> [mybind]gv :<C-u>e $MYGVIMRC<CR>
  nnoremap [mybind]gV :<C-u>source $MYGVIMRC<CR>
endif
if exists('$MYVIMFILES/Vimfile')
  nnoremap <silent> [mybind]bv :<C-u>e $MYVIMFILES/Vimfile<CR>
  nnoremap [mybind]bV :<C-u>source $MYVIMFILES/Vimfile<CR>
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

" }}}1
"===============================================================================

"===============================================================================
" Function: "{{{1

"-------------------------------------------------------------------------------
" WindowResize: "{{{2

function! GoodWinWidth()
  let w = float2nr((2.0 / 3.0) * &columns)
  if winwidth(0) < w
    execute "vertical resize " . w
  endif
  unlet w
endfunction

function! GoodWinHeight()
  let h = float2nr((2.0 / 3.0) * &lines)
  if winheight(0) < h
    execute "botright resize " . h
  endif
  unlet h
endfunction

" }}}2
"-------------------------------------------------------------------------------

" 雑: GetPageTitle('http://hoge.com/fuga')
" 雑: i<C-r>=GetPageTitle(@*)
function! GetPageTitle(url)
  return system('curl --silent ' . a:url . " | grep '<title>' | sed -e 's/\\<title\\>//g' | sed -e 's/\\<\\/title\\>//g' | sed -e 's/ *$//g' | sed -e 's/^ *//g' | sed -e 's/\\n$//g'")
endfunction

" }}}1
"===============================================================================

"===============================================================================
" Platform: "{{{1

if s:iswin
  set shell=bash
else
  set shell=zsh
endif

if filereadable($HOME.'/.vimrc.local')
  source $HOME/.vimrc.local
endif

" }}}1
"===============================================================================

"===============================================================================
" Other: "{{{1

" Enable syntax color.
syntax on

" Enable mouse support.
set mouse=a

" Use Japanese or English help.
" 真のVimmerはen
set helplang& helplang=ja,en

set secure

" }}}1
"===============================================================================

" vim: foldmethod=marker foldlevel=0
