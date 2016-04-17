#===============================================================================
# Note: "{{{1
# .config/zsh/options
#
# Author: iyuuya <i.yuuya@gmail.com>
#
# Zshオプション設定ファイル
#
# }}}1
#===============================================================================

#===============================================================================
# Changing Directories: "{{{1
# - ディレクトリ移動 -

# コマンド名が無い場合はその名前でcdを試みる
set -o AUTO_CD
# cdしたらカレントディレクトリをpushdする
set -o AUTO_PUSHD
# ディレクトリが見つからない場合に先頭に~をつけて試行する
#set -o CDABLE_VARS
# リンク先を絶対参照して..を処理する
#set -o CHASE_DOTS
# どんなときもsymlinkを追跡してオリジナルにcdする
set -o CHASE_LINKS
# よりPOSIX標準に準拠する
#set -o POSIX_CD
# 同じディレクトリは2度pushdしない
set -o PUSHD_IGNORE_DUPS
# pushdの+と-の意味を交換する
#set -o PUSHD_MINUS
# pushdやpopdで標準出力に何も表示しない
#set -o PUSHD_SILENT
# 引数なしのpushdは'pushd $HOME'になる
#set -o PUSHD_TO_HOME

# }}}1
#===============================================================================

#===============================================================================
# Completion: "{{{1
# - 補完 -

# 補完の出力を上書きせずに何度もプリントする
#set +o ALWAYS_LAST_PROMPT
# 完全な補完をしたらカーソルを末尾へ移動する
set -o ALWAYS_TO_END
# 曖昧な補完で候補をリストアップしない
#set +o AUTO_LIST
# Tabキーを連打しても選択を移動しない
#set +o AUTO_MENU
# 変数がディレクトリの場合に変数名をディレクトリ名として使用できる
#set -o AUTO_NAME_DIRS
# 変数名の賢い補完
#set +o AUTO_PARAM_KEYS
# ディレクトリを補完すると最後がスペースではなくスラッシュになる
#set +o AUTO_PARAM_SLASH
# ディレクトリの補完で付いたスラッシュを自動的に削除する
#set +o AUTO_REMOVE_SLASH
# Tabを3回押すまでリスト表示しない(ただしMENU_COMPLETEが優先される)
#set -o BASH_AUTO_LIST
# エイリアスを別のコマンド名として処理する
set -o COMPLETE_ALIASES
# カーソル部分から補完を開始する
set -o COMPLETE_IN_WORD
# 補完のグロブを展開せずに適合ワードをサイクルする
set -o GLOB_COMPLETE
# 最初のコマンド補完時にpathの内容をハッシュしない
#set +o HASH_LIST_ALL
# 補完候補が一意の時もリスト表示する
#set +o LIST_AMBIGUOUS
# Tabを押して補完が成功しない時にビープで通知しない
set +o LIST_BEEP
# コンパクトにして表示量を多くする
set -o LIST_PACKED
# 選択時に横方向に移動する
#set -o LIST_ROWS_FIRST
# ファイルの末尾に種別の識別記号をつける
#set +o LIST_TYPES
# リスト表示のときにはじめから一つ挿入する
set -o MENU_COMPLETE
# 曖昧さが残っていても補完を終了する
#set -o REC_EXACT

# }}}1
#===============================================================================

#===============================================================================
# Expansion and Globbing: "{{{1
# - 展開とグロブ -

# 不正なパターン時にエラーメッセージを表示しない
#set +o BAD_PATTERN
# グロブを適切に処理
#set +o BARE_GLOB_QUAL
# ブレース展開式がただの文字列の場合に一文字ずつ展開
set -o BRACE_CCL
# 大文字小文字を区別しない
#set +o CASE_GLOB
# 正規表現を使用しない
#set +o CASE_MATCH
# Csh形式でグロブを扱う
set -o CSH_NULL_GLOB
# =をグロブに使用できなくする
#set +o EQUALS
# グロブに追加文字を使用する
set -o EXTENDED_GLOB
# 数値計算を浮動小数点計算として扱う
#set -o FORCE_FLOAT
# グロブを使用しない
#set +o GLOB
# 代入式の右辺で不明確なグロブ展開を使用する(非推奨)
#set -o GLOB_ASSIGN
# 明確な場合はファイル名先頭のドットを必要としない
set -o GLOB_DOTS
# **/*を**、***/*を***と省略できる
#set -o GLOB_STAR_SHORT
# 変数の内容も展開に使用する
#set -o GLOB_SUBST
# sや&の展開修飾マッチングをパターンマッチにする
set -o HIST_SUBST_PATTERN
# ブレース展開を無効化する
#set -o IGNORE_BRACES
# コマンド最後の閉じ大カッコ}が必要なくなる。ただし最後のコマンドに;がないとエラーになる
#set -o IGNORE_CLOSE_BRACES
# Ksh形式のグロブを使用する
#set -o KSH_GLOB
# オプションの=以降の補完を可能にする
set -o MAGIC_EQUAL_SUBST
# グロブ展開後のディレクトリには末尾に/を付加する
set -o MARK_DIRS
# マルチバイト文字を扱わない
#set +o MULTIBYTE
# ファイル生成パターンのエラーを表示しない
#set +o NOMATCH
# エラー表示の代わりにパターンを除去する
#set -o NULL_GLOB
# ファイル名生成を辞書順ではなく数値順にする
set -o NUMERIC_GLOB_SORT
# 展開に含まれる配列を別々に展開する
set -o RC_EXPAND_PARAM
# 正規表現マッチング(PARAM =~ REGEXP)でperl形式(PCRE)を使用可能にする
#set +o REMATCH_PCRE
# kshやshのグロブ
#set -o SH_GLOB
# 定義されていない変数を空文字の変数として扱わない(エラーになる)
#set +o UNSET
# 関数内の変数がグローバルとして定義されたら警告を出す
#set -o WARN_CREATE_GLOBAL

# }}}1
#===============================================================================

#===============================================================================
# History: "{{{1
# - コマンド履歴 -

# ヒストリファイルをセッションごとに上書きする
#set +o APPEND_HISTORY
# Csh形式のヒストリ拡張を使用しない
#set +o BANG_HIST
# ヒストリにコマンド実行時間を含める
set -o EXTENDED_HISTORY
# 書き込みリダイレクトで既存ファイル上書きを許可する
#set -o HIST_ALLOW_CLOBBER
# 存在しないヒストリの場合ビープで通知する
#set +o HIST_BEEP
# ヒストリが削られる場合、以前入力した同じものを先に削除する
#set -o HIST_EXPIRE_DUPS_FIRST
# 書き込み中のヒストリファイルをロックする際にfcntlを使用する
set -o HIST_FCNTL_LOCK
# ヒストリ検索時に以前見たものを2度は表示しない
#set -o HIST_FIND_NO_DUPS
# 以前と同じコマンドはヒストリに保存しない
set -o HIST_IGNORE_ALL_DUPS
# 直前のコマンドと同じコマンドはヒストリに保存しない
set -o HIST_IGNORE_DUPS
# 行頭がスペースのコマンドはヒストリに保存しない
set -o HIST_IGNORE_SPACE
# ヒストリファイルの形式を変更する
#set -o HIST_LEX_WORDS
# ヒストリから関数定義を除去する
set -o HIST_NO_FUNCTIONS
# ヒストリコマンドをヒストリから取り除く
set -o HIST_NO_STORE
# ヒストリ保存時に余分な空白を除去する
set -o HIST_REDUCE_BLANKS
# ヒストリを一旦コピーファイルに保存しない
#set +o HIST_SAVE_BY_COPY
# ヒストリファイルに書き出すときに以前のコマンドと同じものを除去する
set -o HIST_SAVE_NO_DUPS
# ヒストリコマンドを直接実行しない
set -o HIST_VERIFY
# ヒストリをヒストリファイルに即座に書き込む
set -o INC_APPEND_HISTORY
# ヒストリ書き込み時間をヒストリファイルに追加する
#set -o INC_APPEND_HISTORY_TIME
# ヒストリの読み出しと書き込みを同時に行う
set -o SHARE_HISTORY

# }}}1
#===============================================================================

#===============================================================================
# Initialisatons: "{{{1
# - 環境の初期化 -

# すべての変数を自動的にexportする
#set -o ALL_EXPORT
# エクスポートフラグ(-x)をもつ変数が自動的にグローバル(-g)にならない
#set +o GLOBAL_EXPORT
# 起動時に/etc/zshenvを除く/etc以下の設定ファイル群を読み込まない
#set +o GLOBAL_RCS
# 起動時に/etc/zshenvを除く全ての設定ファイルを読み込まない
#set +o RCS

# }}}1
#===============================================================================

#===============================================================================
# Input/Output: "{{{1
# - 入力と出力 -
#
# 他人のzshとの互換性を重視するならば
# 変更は好ましくないものがある。

# エイリアスを拡張しない
#set +o ALIASES
# リダイレクトによる入出力制御
#set +o CLOBBER
# スペルミスの修正をする
set -o CORRECT
# コマンド行のすべての引数に対してスペルミスの修正を行う
set -o CORRECT_ALL
# スペルミスの修正時にDvorak配列として修正する
#set -o DVORAK
# フロー制御(Ctrl+s,Ctrl+q)を無効化する
set +o FLOW_CONTROL
# EOFを読み込んでも終了しない
set -o IGNORE_EOF
# 対話的シェル(Interactive)でも#以降をコメントとみなす
#set -o INTERACTIVE_COMMENTS
# コマンドの場所をそのコマンドの最初の実行時にハッシュしない
#set +o HASH_CMDS
# コマンドのハッシュ時にそれを含むディレクトリをハッシュしない
#set +o HASH_DIRS
# 実行権限が付与されているコマンド以外はハッシュしない
#set -o HASH_EXECUTABLES_ONLY
# メールファイルにアクセスがあると警告を発する
set -o MAIL_WARNING
# コマンド名に/が含まれていてもそれを含めたパスの探索を行う
set -o PATH_DIRS
# 効果不明
#set -o PATH_SCRIPT
# マルチバイト文字を処理する(既に問題ない場合には必要ない)
#set -o PRINT_EIGHT_BIT
# 終了コード($?)を表示する
#set -o PRINT_EXIT_VALUE
# シングルクォート内でのシングルクォートを許可する
#set -o RC_QUOTES
# 'rm *'の実行時に警告を表示しない
#set -o RM_STAR_SILENT
# 'rm *'の実行前に10秒間の猶予を与える
#set -o RM_STAR_WAIT
# 省略形式のループ(for等)を許可しない
#set +o SHORT_LOOPS
# バッククォートの数が合わない時に最後のバッククォートを無視する
#set -o SUN_KEYBOARD_HACK

# }}}1
#===============================================================================

#===============================================================================
# Job Control: "{{{1
# - ジョブコントロール -

# disownコマンドでジョブテーブルから除去したjobに自動的にCONTシグナルを送信する
set -o AUTO_CONTINUE
# サスペンドしたjobをそのコマンド名で再開する
set -o AUTO_RESUME
# バックグラウンドjobのプライオリティ(優先度)を下げない
#set +o BG_NICE
# バックグラウンドjobがある際にzshを終了しても何も警告しない
#set +o CHECK_JOBS
# 実行中のjobがあるときにzshを終了するとそのジョブにHUPシグナルを送信しない(道連れにする)
#set +o HUP
# jobsで表示されるjobリストを冗長にする
set -o LONG_LIST_JOBS
# jobコントロールを許可する(インタラクティブシェルではデフォルト)
#set -o MONITOR
# バックグラウンドjobが終了しても即座に通知しない
#set +o NOTIFY
# POSIX標準に準拠したjobコントロールを使用する
#set -o POSIX_JOBS

# }}}1
#===============================================================================

#===============================================================================
# Prompting: "{{{1
# - プロンプト表示 -

# プロンプトで!を特殊文字として扱わない
#set +o PROMPT_BANG
# プロンプトで改行コードの無い行を出力しない
#set +o PROMPT_CR
# PROMPT_CRで出力されなかった行を反転文字で通知
#set +o PROMPT_SP
# プロンプトで%を特殊文字として扱わない
#set +o PROMPT_PERCENT
# プロンプトで拡張変数などを利用する
set -o PROMPT_SUBST
# コマンド実行時に右プロンプトの表示を削除する
set -o TRANSIENT_RPROMPT
# }}}1
#===============================================================================

#===============================================================================
# Scripts and Functions: "{{{1
# - スクリプトと関数 -

#set -o C_BASES
#set -o C_PRECEDENCES
#set -o DEBUG_BEFORE_CMD
#set -o ERR_EXIT
#set -o ERR_RETURN
#set +o EVAL_LINENO
#set +o EXEC
#set +o FUNCTION_ARGZERO
#set -o LOCAL_LOOPS
#set -o LOCAL_OPTIONS
#set -o LOCAL_PATTERNS
#set -o LOCAL_TRAPS
#set +o MULTI_FUNC_DEF
#set +o MULTIOS
#set -o OCTAL_ZEROES
#set -o PIPE_FAIL
#set -o SOURCE_TRACE
#set -o TYPESET_SILENT
#set -o VERBOSE
#set -o XTRACE

# }}}1
#===============================================================================

#===============================================================================
# Shell Emulation: "{{{1
# - 互換とエミュレーション -

#set -o APPEND_CREATE
#set -o BASH_REMATCH
#set -o BSD_ECHO
#set -o CONTINUE_ON_ERROR
#set -o CSH_JUNKIE_HISTORY
#set -o CSH_JUNKIE_LOOPS
#set -o CSH_JUNKIE_QUOTES
#set -o CSH_NULLCMD
#set -o KSH_ARRAYS
#set -o KSH_AUTOLOAD
#set -o KSH_OPTION_PRINT
#set -o KSH_TYPESET
#set -o KSH_ZERO_SUBSCRIPT
#set -o POSIX_ALIASES
#set -o POSIX_ARGZERO
#set -o POSIX_BUILTINS
#set -o POSIX_IDENTIFIERS
#set -o POSIX_STRINGS
#set -o POSIX_TRAPS
#set -o SH_FILE_EXPANSION
#set -o SH_NULLCMD
#set -o SH_OPTION_LETTERS
#set -o SH_WORD_SPLIT
#set -o TRAPS_ASYNC

# }}}1
#===============================================================================

#===============================================================================
# Shell State: "{{{1
# - シェルの種類 -

#set -o INTERACTIVE
#set -o LOGIN
#set -o PRIVILEGED
#set -o RESTRICTED
#set -o SHIN_STDIN
#set -o SINGLE_COMMAND

# }}}1
#===============================================================================

#===============================================================================
# Zsh Line Editor (ZLE): "{{{1
# - ZLE -

# ZLEのエラー時にビープで通知しない
set +o BEEP
# 通常では使用されない特殊記号を正しく表示する
#set -o COMBINING_CHARS
# Emacsのキーバインディングを使用する
#set -o EMACS
# ZLEをOverstrikeモードで起動
#set -o OVERSTRIKE
# シングルラインエディットにする
#set -o SINGLE_LINE_ZLE
# Viのキーバインディングを使用する
set -o VI
# ZLEを使用する(インタラクティブシェルではデフォルト)
set -o ZLE
# }}}1
#===============================================================================

# vim: ft=zsh fdm=marker et sw=2 sts=2 ts=2
