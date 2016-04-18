"===============================================================================
" Note: "{{{1
" .gvimrc
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

"===============================================================================
" Window: "{{{1
"

if my#ismac()
  set columns=160
  set lines=44
  nnoremap <silent> <C-e>fl :<C-u>set columns=320 lines=68<CR>:winpos 0 0<CR>
  nnoremap <silent> <C-e>fL :<C-u>set columns=319 lines=70<CR>:winpos -1920 0<CR>
  set transparency=0
elseif my#iswin()
  set columns=128
  set lines=36
else
  set columns=180
  set lines=52
endif

" }}}1
"===============================================================================

"===============================================================================
" Menu: "{{{1
"

" Hide toolbar.
set guioptions-=T

if !my#ismac()
  " For Windows
  " Hide menus.
  set guioptions-=m
  " Toggle menu open if press <F2>.
  nnoremap <silent> <F2> :<C-u>if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \else <Bar>
        \set guioptions+=m <Bar>
        \endif <CR>
endif

" Scrollbar is always off.
set guioptions-=rL
" Not GUI tab label.
set guioptions-=e

" }}}1
"===============================================================================

"===============================================================================
" Font: "{{{1
"

if my#ismac()
  " For MacOSX.

  " Use antialias
  set antialias

  " set guifont=Ricty_Discord_Regular_for_Powerline:h12
  set guifont=Sauce_Code_Powerline:h12

  " Number of pixel lines inserted between characters.
  set linespace=2
elseif my#iswin() || my#iscygwin()
  " For Windows.
  set guifont=Meslo_LG_S_for_Powerline:h10:cANSI
  " Number of pixel lines inserted between characters.
  set linespace=2
else
  " For Linux.
  let &guifont="Ricty\ 11"
  " Number of pixel lines inserted between characters.
  set linespace=0
endif

" }}}1
"===============================================================================

"===============================================================================
" Views: "{{{1
"

" Disable bell.
set vb t_vb=

colorscheme molokai

" }}}1
"===============================================================================

"===============================================================================
" Mouse: "{{{1
"

" Show popup menu if right click.
set mousemodel=popup

" Don't focus the window when the mouse pointer is moved.
set nomousefocus
" Hide mouse pointer on insert mode.
set mousehide

" }}}1
"===============================================================================

"===============================================================================
" Key Mapping: "{{{1
"

if my#ismac()
  " Transparency key map
  nnoremap ,ad :set transparency=0<CR>
  nnoremap ,ae :set transparency=10<CR>
  nnoremap ,at :<C-u>TransparencyToggle<CR>
endif

" }}}1
"===============================================================================

"===============================================================================
" Command: "{{{1
"

if my#ismac()
  command! TransparencyToggle let &transparency = (&transparency != 0 && &transparency != 100) ? 0 : 3
endif

" }}}1
"===============================================================================

if filereadable($HOME.'/.gvimrc.local')
  source $HOME/.gvimrc.local
endif

" vim: foldmethod=marker foldlevel=0
