scriptencoding utf-8

if has('vim_starting')
  set nocompatible

  if !exists('$MYVIMRC')
    let $MYVIMRC = expand('~/.nvimrc')
  endif

  if !exists('$MYVIMFILES')
    let $MYVIMFILES = expand('~/.nvim')
  endif
endif

function! s:mkdir_p(path)
  if !isdirectory(a:path)
    call mkdir(a:path)
  endif
endfunction

if !exists('g:nvim_tmpdir')
  let g:nvim_tmpdir = expand($MYVIMFILES . '/tmp')
endif
call s:mkdir_p(g:nvim_tmpdir)

let mapleader = ','
let maplocalleader = 'm'

nnoremap <LocalLeader> <Nop>
xnoremap <LocalLeader> <Nop>
nnoremap <leader> <Nop>
xnoremap <leader> <Nop>

filetype plugin indent on

set backup
set nowritebackup
set backupcopy=auto
let &backupdir = g:nvim_tmpdir . '/backup'
call s:mkdir_p(&backupdir)

set swapfile
let &directory = g:nvim_tmpdir . '/swap'
call s:mkdir_p(&directory)
set updatetime=10000

set undofile
let &undodir = g:nvim_tmpdir . '/udno'
call s:mkdir_p(&undodir)

set autoread

set timeout
set timeoutlen=700
set ttimeoutlen=100

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp
set fileformat=unix
set fileformats=unix,dos,mac

set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set smarttab
set expandtab
set autoindent
set smartindent

augroup KeywordPrgCmd
  autocmd!
  autocmd FileType vim         setlocal keywordprg=:help
  autocmd FileType sh,bash,zsh setlocal keywordprg=man\ -s
augroup END

set splitright
set splitbelow

set foldenable
set foldlevelstart=99
set foldcolumn=1
set foldmethod=syntax

augroup FoldAutoCmd
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

set ignorecase
set smartcase
set infercase
set incsearch
set hlsearch
set wrapscan

if executable('ag')
  set grepprg=ag\ --nogroup\ -iS
  set grepformat=%f:%l:%m
else
  set grepprg=grep\ -Hnd\ skip\ -r
  set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
endif

augroup VimGrepAutoCmd
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

nnoremap ? /
nnoremap / :vimgrep  %<left><left>
nnoremap <C-n> n
nnoremap <C-p> N
nnoremap n :cnext<CR>
nnoremap N :cprevious<CR>

set backspace=indent,eol,start

augroup MyAutoCmd
  autocmd FileType sh,bash,zsh setlocal keywordprg=man\ -s
  autocmd FileType vim setlocal keywordprg=:help
augroup END

set clipboard=

set number
set numberwidth=4
set norelativenumber
set ruler

set list
set listchars=tab:>-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

set nowrap
nnoremap <Leader>tw :<C-u>setlocal wrap! wrap?<CR>

syntax enable

set modeline
set secure

" vim: ts=2 sts=2 sw=2 et
