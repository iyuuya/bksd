"===============================================================================
" Note: "{{{0
" .vimrc
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}0
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

  " Utility "{{{3
  " Interactive command execution in Vim.
  NeoBundle 'Shougo/vimproc', {
        \ 'build' : {
        \   'win64' : 'nmake -f make_msvc32.mak',
        \   'win32' : 'nmake -f make_msvc64.mak',
        \   'mac'   : 'make -f make_mac.mak',
        \   'unix'  : 'make -f make_unix.mak',
        \   },
        \ }
  NeoBundle 'Shougo/unite.vim'       " Unite and create user interfaces
  NeoBundle 'h1mesuke/unite-outline' " outline source for unite.vim
  NeoBundle 'tacroe/unite-mark'
  NeoBundle 'mattn/webapi-vim'       " vim interface to Web API
  NeoBundle 'tyru/open-browser.vim'  " Open URI with your favorite browser from your favorite editor
  NeoBundle 'Shougo/vimshell.vim'    " Powerful shell implemented by vim.
  NeoBundle 'ujihisa/vimshell-ssh'   " the world first vimshell plugin that you can run 'vim' command on ssh on vimshell
  NeoBundle 'Shougo/vimfiler.vim'    " Powerful file explorer implemented by Vim script
  NeoBundle 'AndrewRadev/switch.vim' " A simple Vim plugin to switch segments of text with predefined replacements
  " }}}3

  " View "{{{3
  NeoBundle 'vim-scripts/molokai'     " A port of the monokai scheme for TextMate
  NeoBundle 'Lokaltog/vim-powerline'  " The ultimate vim statusline utility.
  " }}}3

  " Edit "{{{3
  if has('lua')
    NeoBundle 'Shougo/neocomplete.vim' " Next generation completion framework after neocomplcache
  endif
  NeoBundle 'Shougo/neosnippet.vim' " neo-snippet plugin contains neocomplcache snippets source
  NeoBundle 'agate/vim-align'
  " endwise.vim: wisely add 'end' in ruby, endfunction/endif/more in vim script, etc
  NeoBundleLazy 'alpaca-tc/vim-endwise', { 'autoload' : { 'insert' : 1 } }
  " A git repository for a vim plugin called matchit
  NeoBundleLazy 'edsono/vim-matchit', { 'autoload' : {
        \ 'filetypes' : 'ruby',
        \ 'mappings' : ['nx', '%'] } }
  " }}}3

  " Vim "{{{3
  NeoBundle 'thinca/vim-scouter'        " Measures Battle Power of a vimmer.
  NeoBundle 'zhaocai/unite-scriptnames' " unite.vim extension for runtime scriptnames
  NeoBundle 'ujihisa/unite-colorscheme' " A unite.vim plugin
  NeoBundle 'tsukkee/unite-help' " help source for unite.vim
  " }}}3

  " FileType "{{{3
  " Ruby/Rails "{{{4
  NeoBundle 'ujihisa/unite-rake'  " A Unite.vim plugin to run tasks or to view descriptions easily, using rake command
  NeoBundle 'basyura/unite-rails' " a unite.vim plugin for rails
  " }}}4
  " Web "{{{4
  NeoBundle 'othree/html5.vim' " HTML5 omnicomplete and syntax
  NeoBundleLazy 'hail2u/vim-css3-syntax', { 'autoload' : { 'filetypes' : ['scss', 'sass', 'less', 'css'] } } " Add CSS3 syntax support to vim's built-in `syntax/css.vim`.
  NeoBundleLazy 'cakebaker/scss-syntax.vim', { 'autoload' : { 'filetypes' : ['scss', 'sass', 'css'] } } " Vim syntax file for scss (Sassy CSS)
  NeoBundleLazy 'groenewege/vim-less', { 'autoload' : { 'filetypes' : ['less', 'css'] } } " vim syntax for LESS (dynamic CSS)
  NeoBundleLazy 'digitaltoad/vim-jade', { 'autoload' : { 'filetypes' : ['jade'] } } " Vim Jade template engine syntax highlighting and indention
  NeoBundleLazy 'kchmck/vim-coffee-script', { 'autoload' : { 'filetypes' : ['coffee', 'js'] } } " CoffeeScript support for vim
  NeoBundle 'skammer/vim-css-color'     " Highlight colors in css files
  " }}}4
  if has('mac')
    NeoBundle 'vim-scripts/cocoa.vim' " Plugin for Cocoa/Objective-C development
  endif
  " }}}3

  " Dictionary "{{{3
  NeoBundle 'pasela/unite-webcolorname' " A unite source plugin which provides Web Color Names.
  NeoBundle 'mackee/unite-httpstatus'
  " }}}3

  " VCS "{{{3
  NeoBundle 'tpope/vim-fugitive'  " fugitive.vim: a Git wrapper so awesome, it should be illegal
  NeoBundle 'gregsexton/gitv'     " gitk for Vim.
  NeoBundle 'mattn/gist-vim'      " vimscript for gist
  NeoBundle 'kmnk/vim-unite-giti' " unite source for using git
  NeoBundle 'mattn/unite-gist'    " unite source gist
  " }}}3

  " Fun "{{{3
  NeoBundle 'osyo-manga/unite-banban'
  NeoBundle 'mattn/unite-nyancat'
  NeoBundle 'osyo-manga/unite-moo'
  NeoBundle 'osyo-manga/unite-homo'
  " }}}3

  "{{{4
  if 0 " old bundles
    NeoBundle 'basyura/TweetVim'
    NeoBundle 'basyura/twibill.vim'

    if !s:iswin
      NeoBundle 'Shougo/neocomplcache-rsense' " The neocomplcache source for RSense
      NeoBundle 'alpaca-tc/vim-rsense' " rsense/etc/vimrsense copy
    endif

    " Run commands quickly.
    NeoBundle 'thinca/vim-quickrun'
    " A quickrun plugin to show intermediate codes
    NeoBundle 'ujihisa/quicklearn'

    " zen-coding for vim: http://code.google.com/p/zen-coding/
    NeoBundle 'mattn/zencoding-vim'
    " surround.vim: quoting/parenthesizing made simple
    NeoBundle 'tpope/vim-surround', {
          \ 'autoload' : {
          \   'mappings' : [
          \     ['nx', '<Plug>Dsurround'], ['nx', '<Plug>Csurround'],
          \     ['nx', '<Plug>Ysurround'], ['nx', '<Plug>YSurround'],
          \     ['nx', '<Plug>Yssurround'], ['nx', '<Plug>YSsurround'],
          \     ['vx', '<Plug>VgSurround'], ['vx', '<Plug>VSurround'],
          \ ]}}

    " Beautiful rspec output in vim. See also: https://github.com/skwp/vim-ruby-conque for non-blocking rspec through ConqueTerm
    NeoBundle 'thinca/vim-ref' " Integrated reference viewer.
    NeoBundleLazy 'yuku-t/vim-ref-ri', { 'autoload' : { 'filetypes' : ['ruby', 'eruby', 'haml', 'rspec', 'Gemfile'] } }

    NeoBundle 'altercation/vim-colors-solarized' " precision colorscheme for the vim text editor
    NeoBundleLazy 'rcyrus/snipmate-snippets-rubymotion', { 'autoload' : { 'filetypes' : ['rubymotion'] } }
    NeoBundle 'thinca/vim-template'

    " Run Rspec specs from Vim
    NeoBundle 'thoughtbot/vim-rspec'
    " rails.vim: Ruby on Rails power tools
    NeoBundle 'tpope/vim-rails', { 'autoload' : {
          \ 'filetypes' : ['haml', 'ruby', 'eruby'] } }
    " Provides database access to many DBMS (Oracle, Sybase, Microsoft, MySQL, DBI,..)
    NeoBundle 'dbext.vim'

    NeoBundle 'szw/vim-tags'
    NeoBundle 'slim-template/vim-slim' " A clone of the slim vim plugin from stonean. For use with Pathogen.

    NeoBundle 'koron/chalice' " Chalice for Vim - 2ch.net browser written in vim script.

    NeoBundle 'dmitry-ilyashevich/vim-typescript' " Vim TypeScript syntax mirror for bundle
  endif
  "}}}4

  if 0 "{{{4
    NeoBundle 'tsukkee/unite-tag'
    NeoBundle 'osyo-manga/unite-quickfix'
    NeoBundle 'ujihisa/unite-gem'

    NeoBundle 'rhysd/unite-ruby-require.vim'
    NeoBundle 'eagletmt/unite-haddock' " unite.vim source for haddock
    NeoBundle 'basyura/unite-twitter' " twitter plugin for unite
    NeoBundle 'yomi322/unite-tweetvim'           " unite source for tweetvim
    NeoBundle 'mopp/unite-rss'
    NeoBundle 'mattn/unite-remotefile'           " unite source for remote file                                                                         
    NeoBundle 'moro/unite-stepdefs'              " unite-vim source for completing Cucumber step definition.                                            
    NeoBundle 'nise-nabe/unite-openpne'          "                                                                                                      
    NeoBundle 'osyo-manga/unite-qfixhowm'        "                                                                                                      
    NeoBundle 'osyo-manga/unite-quickfix'        "                                                                                                      
    NeoBundle 'osyo-manga/unite-rofi'            "                                                                                                      
    NeoBundle 'osyo-manga/unite-sl'              "                                                                                                      
    NeoBundle 'pocket7878/unite-hyperspec'       " unite source for lookup hyperspec contents.                                                          
    NeoBundle 'raomito/unite-memolist'           "                                                                                                      
    NeoBundle 'ryotakato/unite-gradle'           " vim plugin. unite source for using Gradle.                                                           
    NeoBundle 'ryotakato/unite-mongodb'          " vim plugin. unite source for using MongoDB.                                                          
    NeoBundle 'ryotakato/unite-sqlserver'        " vim plugin. unite source for using SQL Server                                                        
    NeoBundle 'sgur/unite-everything'            " A source which uses result of everything (http://www.voidtools.com/) for unite.vim                   
    NeoBundle 'sgur/unite-git_grep'              " git-grep source for unite.vim inspired by http://subtech.g.hatena.ne.jp/secondlife/20080606/121272942
    NeoBundle 'shiena/unite-path'                " Enumerate the PATH environment variable by unite.                                                    
    NeoBundle 'Shougo/unite-session'             " unite.vim session source                                                                             
    NeoBundle 'Shougo/unite-ssh'                 " unite.vim for SSH source                                                                             
    NeoBundle 'Shougo/unite-sudo'                " sudo source for unite.vim                                                                            
    NeoBundle 'smackesey/my_unite'               " Unite Sources for Vim                                                                                
    NeoBundle 'soh335/unite-hatenabookmark'      "                                                                                                      
    NeoBundle 'soh335/unite-qflist'              " unite-qflist                                                                                         
    NeoBundle 'soh335/unite-quickhl'             "                                                                                                      
    NeoBundle 'termoshtt/unite-nozbe'            " unite.vim source for Nozbe                                                                           
    NeoBundle 'tsukkee/unite-tag'                " tags soruce for unite.vim                                                                            
    NeoBundle 'ujihisa/unite-font'               " A unite plugin                                                                                       
    NeoBundle 'ujihisa/unite-haskellimport'      "                                                                                                      
    NeoBundle 'ujihisa/unite-locate'             "                                                                                                      
  endif "}}}4

  NeoBundleCheck
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

"-------------------------------------------------------------------------------
" Unite: "{{{2

if globpath(&rtp, 'bundle/unite.vim') != ''
  let g:unite_enable_start_insert = 0
  let g:unite_enable_split_vertically = 0
  let g:unite_source_history_yank_enable = 1
  let g:unite_data_directory = g:vim_tmp_directory."/unite"

  nnoremap <S-Space> :<C-u>Unite -start-insert source<CR>
  " unite.vim
  nnoremap [unite] <nop>
  nmap <C-k> [unite]
  nnoremap [unite]   :<C-u>Unite 
  nnoremap [unite]uf :<C-u>Unite file_point file buffer file_mru file_rec/async directory directory_mru directory_rec/async<CR>
  nnoremap [unite]ub :<C-u>Unite bookmark<CR>
  nnoremap [unite]us :<C-u>Unite source<CR>
  nnoremap [unite]ui :<C-u>Unite find<CR>
  nnoremap [unite]un :<C-u>Unite function<CR>
  nnoremap [unite]uy :<C-u>Unite history/yank<CR>
  nnoremap [unite]ug :<C-u>Unite grep<CR>
  nnoremap [unite]uj :<C-u>Unite -start-insert jump<CR>
  nnoremap [unite]uc :<C-u>Unite -start-insert launcher<CR>
  nnoremap [unite]ul :<C-u>Unite -start-insert line/fast<CR>
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
  nnoremap [unite]rf :<C-u>Unite rails/config<CR>
  nnoremap [unite]rc :<C-u>Unite rails/controller<CR>
  nnoremap [unite]rd :<C-u>Unite rails/db<CR>
  nnoremap [unite]ry :<C-u>Unite rails/destroy<CR>
  nnoremap [unite]rg :<C-u>Unite rails/generate<CR>
  nnoremap [unite]rh :<C-u>Unite rails/helper<CR>
  nnoremap [unite]ri :<C-u>Unite rails/initializer
  nnoremap [unite]rj :<C-u>Unite rails/javascript<CR>
  nnoremap [unite]rl :<C-u>Unite rails/lib<CR>
  nnoremap [unite]ro :<C-u>Unite rails/log<CR>
  nnoremap [unite]ra :<C-u>Unite rails/mailer<CR>
  nnoremap [unite]rm :<C-u>Unite rails/model<CR>
  nnoremap [unite]rr :<C-u>Unite rails/route<CR>
  nnoremap [unite]rp :<C-u>Unite rails/spec<CR>
  nnoremap [unite]rs :<C-u>Unite rails/stylesheet<CR>
  nnoremap [unite]rv :<C-u>Unite rails/view<CR>
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
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" VimShell: "{{{2

if globpath(&rtp, 'bundle/vimshell.vim') != ''
  let g:vimshell_interactive_update_time = 10
  let g:vimshell_temporary_directory = g:vim_tmp_directory."/vimshell"
  let g:vimshell_max_command_history = 10000

  let g:vimshell_prompt = '% '
  let g:vimshell_user_prompt = "$USER.'@'.hostname().'('.strftime('%Y/%m/%d %H:%M:%S').')>>'"
  let g:vimshell_secondary_prompt = '> '
  let g:vimshell_right_prompt = "'['.fnamemodify(getcwd(), ':~').']'"

  autocmd FileType vimshell call vimshell#hook#add('chpwd', 'my_chpwd', 'g:my_chpwd')

  function! g:my_chpwd(args, context)
    call vimshell#execute('ls')
  endfunction

  nnoremap ; :VimShellCurrentDir<CR>
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" VimFiler: "{{{2

if globpath(&rtp, 'bundle/vimfiler.vim') != ''
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

if globpath(&rtp, 'bundle/neocomplete.vim') != ''
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#max_list = 100
  let g:neocomplete#max_keyword_width = 40
  let g:neocomplete#auto_completion_start_length = 2
  let g:neocomplete#manual_completion_start_length = 1
  let g:neocomplete#min_keyword_length = 3
  let g:neocomplete#enable_ignore_case = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#force_overwrite_completefunc = 1 " 0でもいいかも
  let g:neocomplete#use_vimproc = 0 " 1でもいいかも
  let g:neocomplete#data_directory = g:vim_tmp_directory."/neocomplete"

  nnoremap ,ne :<C-u>NeoCompleteEnable<CR>
  nnoremap ,nd :<C-u>NeoCompleteDisable<CR>
  nnoremap ,nt :<C-u>NeoCompleteToggle<CR>
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" NeoSnippet: "{{{2

let g:neosnippet#snippets_directory = $MYVIMFILES."/snippets"

" SuperTab like snippets behavior.
imap <expr><C-TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><C-TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

nnoremap <silent>,nse :<C-u>NeoSnippetEdit -split<CR>

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Vim PowerLine: "{{{2

set background=light

if globpath(&rtp, 'bundle/vim-powerline') != ''
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
" Switch: "{{{2

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
      \ 'ruby,eruby,haml' : [
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
    let s:gvn = 'b:switch_custom_definitions'
    if !exists(s:gvn)
      let cmd = 'let ' . s:gvn . ' = ' . string(dictionary)
      exe cmd
    endif
  endif
endfunction"}}}

augroup SwitchSetting
  autocmd!
  autocmd filetype * if !empty(split(&ft, '\.')) | call <SID>define_switch_mappings() | endif
augroup END


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

nnoremap [mybind] Nop
nmap <C-e> [mybind]

" Change current window and size.
nnoremap <silent> [mybind]h <c-w>h:call GoodWinWidth()<cr>
nnoremap <silent> [mybind]j <c-w>j:call GoodWinHeight()<cr>
nnoremap <silent> [mybind]k <c-w>k:call GoodWinHeight()<cr>
nnoremap <silent> [mybind]l <c-w>l:call GoodWinWidth()<cr>

nnoremap <silent> [mybind]eu :<C-u>set fenc=utf-8<CR>
nnoremap <silent> [mybind]ee :<C-u>set fenc=euc-jp<CR>
nnoremap <silent> [mybind]es :<C-u>set fenc=cp932<CR>
nnoremap <silent> [mybind]eU :<C-u>e ++enc=utf-8 %<CR>
nnoremap <silent> [mybind]eE :<C-u>e ++enc=euc-jp %<CR>
nnoremap <silent> [mybind]eS :<C-u>e ++enc=cp932 %<CR>

nnoremap <silent> [mybind]el :<C-u>set fileformat=unix<CR>
nnoremap <silent> [mybind]em :<C-u>set fileformat=mac<CR>
nnoremap <silent> [mybind]ed :<C-u>set fileformat=dos<CR>
nnoremap <silent> [mybind]eL :<C-u>e ++fileformat=unix %<CR>
nnoremap <silent> [mybind]eM :<C-u>e ++fileformat=mac %<CR>
nnoremap <silent> [mybind]eD :<C-u>e ++fileformat=dos %<CR>

nnoremap <silent> [mybind]fm :<C-u>set foldmethod=marker<CR>
nnoremap <silent> [mybind]fi :<C-u>set foldmethod=indent<CR>
nnoremap <silent> [mybind]fs :<C-u>set foldmethod=syntax<CR>

nnoremap <silent> [mybind]cc :<C-u>let &colorcolumn = &colorcolumn == 0 ? 80 : 0<CR>

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

if !s:iswin
  set shell=zsh
else
  set shell=bash
endif

" }}}1
"===============================================================================

"===============================================================================
" Other: "{{{1

" Enable mouse support.
set mouse=a

" Use Japanese or English help.
" 真のVimmerはen
set helplang& helplang=ja,en

colorscheme molokai

set secure

" }}}1
"===============================================================================

" vim: foldmethod=marker foldlevel=0
