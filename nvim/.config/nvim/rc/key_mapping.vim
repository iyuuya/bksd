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

nnoremap <silent> [mybind]/  :vimgrep  %<left><left>
nnoremap <silent> [mybind]n  :cnext<CR>
nnoremap <silent> [mybind]N  :cprevious<CR>

" }}}1
"===============================================================================
" vim: foldmethod=marker
