"=======================================================================================================================
" Note: "{{{1
" File: volt/rc/default/vimrc.vim
" Author: iyuuya <i.yuuya@gmail.com>
" }}}1
"=======================================================================================================================

"=======================================================================================================================
" 初期化: {{{2

" sudo経由でvimを実行した場合、設定を読まない
if exists('$SUDO_USER')
  finish
endif

" Vi非互換に設定(Vimの便利な機能を使う)
if &compatible && has('vim_starting')
  set nocompatible
endif

" ロケール設定
language C

" ファイル形式の検出とファイル形式毎のインデント設定・プラグインを有効にする
filetype indent plugin on
" 構文ハイライトを有効化
" onだとhighlightで設定されたものを破棄してデフォルト値に上書くのでenable
syntax enable

" }}}2
"=======================================================================================================================

"=======================================================================================================================
" エンコーディング: "{{{2

" デフォルトは<NL>
set fileformat=unix
set fileformats=unix,dos,mac

" ファイル編集時に考慮するエンコーディングリスト設定
if has('kaoriya')
  set fileencodings=guess
else
  set fileencodings=ucs-bom,iso-2022-jp-3,utf-8,euc-jisx0213,euc-jp,cp932,cp20932,default,latin1
endif

" }}}2
"=======================================================================================================================

source ~/.vim/rc/search.vim
source ~/.vim/rc/edit.vim
source ~/.vim/rc/view.vim
source ~/.vim/rc/syntax.vim
source ~/.vim/rc/types.vim
source ~/.vim/rc/function.vim
source ~/.vim/rc/command.vim
source ~/.vim/rc/key_mapping.vim
source ~/.vim/rc/platform.vim

" vim: ts=2 sts=2 sw=2 et fdm=marker
