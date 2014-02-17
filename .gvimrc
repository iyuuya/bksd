"===============================================================================
" Note: "{{{1
" .gvimrc
"
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"===============================================================================

"===============================================================================
" Initialize: "{{{1

let s:iswin = has('win32') || has('win64') || has('win95') || has('win16')
let s:iscygwin = has('win32unix')
let s:ismac = has('mac') || has('macunix') || has('gui_mac') || has('gui_macvim') ||
      \ (!executable('xdg-open') && system('uname') =~? '^darwin')
let s:islinux = !s:iswin && !s:iscygwin && !s:ismac

" }}}1
"===============================================================================

"===============================================================================
" Window: "{{{1
"

if s:ismac
  set columns=160
  set lines=44
  nnoremap <silent> <C-e>fl :<C-u>set columns=320 lines=68<CR>:winpos 0 0<CR>
  nnoremap <silent> <C-e>fL :<C-u>set columns=319 lines=70<CR>:winpos -1920 0<CR>
  set transparency=0
elseif s:iswin
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

if !s:ismac
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

if s:ismac
  " For MacOSX.

  " Use antialias
  set antialias

  set guifont=Ricty:h12

  " Number of pixel lines inserted between characters.
  set linespace=2
elseif s:iswin || s:iscygwin
  " For Windows.
  set guifont=Consolas_for_Powerline_FixedD:h10:cANSI
  "let &guifontwide = iconv('Osaka－等幅:h10:cSHIFTJIS', &encoding, 'cp932')
  " Number of pixel lines inserted between characters.
  set linespace=2
else
  " For Linux.
  let &guifont="Ricty\ 11"
  "let &guifontwide="Ricty\ 11"
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

if exists('$VIM_COLORSCHEME')
  exec('colorscheme ' . $VIM_COLORSCHEME)
else
  colorscheme molokai
end

if exists('$VIM_BACKGROUND')
  exec('set background=' . $VIM_BACKGROUND)
end

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

if s:ismac
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

if s:ismac
  command! TransparencyToggle let &transparency = (&transparency != 0 && &transparency != 100) ? 0 : 3
endif

" }}}1
"===============================================================================

" vim: foldmethod=marker foldlevel=0
