#===============================================================================
# Note: "{{{1
# tools.zsh
#
# Author: iyuuya <i.yuuya@gmail.com>
# }}}1
#===============================================================================

#===============================================================================
# Pager: "{{{1

if type lv > /dev/null 2>&1; then
  export PAGER="lv"
else
  export PAGER="less"
fi

# lv: "{{{2

if [ "$PAGER" = "lv" ]; then
  export LV="-c -l"
fi

alias lv="$PAGER"
alias less="$PAGER"

# "}}}2

# "}}}1
#===============================================================================

#===============================================================================
# Grep: "{{{1

# if type ggrep > /dev/null 2>&1; then
#   alias grep=ggrep
# fi
# 
# grep_version="$(grep --version | head -n 1 | sed -e 's/^[^0-9.]*\([0-9.]*\)$/\1/')"
# 
# export GREP_OPTIONS
# GREP_OPTIONS="--binary-files=without-match"
# case "$grep_version" in
#   1.*|2.[0-4].*|2.5.[0-3])
#     ;;
#   *)
#     # grep >= 2.5.4
#     # ディレクトリを再帰的にgrep
#     GREP_OPTIONS="--directories=recurse $GREP_OPTIONS"
#     ;;
# esac
# 
# # color
# if grep --help | grep -q -- --color; then
#   GREP_OPTIONS="--color=auto $GREP_OPTIONS"
# fi

# "}}}1
#===============================================================================

#===============================================================================
# sed: "{{{1

if type gsed > /dev/null 2>&1; then
  alias sed=gsed
fi

# "}}}1
#===============================================================================

#===============================================================================
# editor: "{{{1

if ! type vim > /dev/null 2>&1; then
  alias vim=vi
fi

export EDITOR=vim

# "}}}1
#===============================================================================

#===============================================================================
# Shell: "{{{1

if type /bin/zsh > /dev/null 2>&1; then
  export SHELL=/bin/zsh
fi

if type /usr/bin/zsh > /dev/null 2>&1; then
  export SHELL=/usr/bin/zsh
fi

if type /usr/local/bin/zsh > /dev/null 2>&1; then
  export SHELL=/usr/local/bin/zsh
fi

if type $HOME/brew/bin/zsh > /dev/null 2>&1; then
  export SHELL=$HOME/brew/bin/zsh
fi
# "}}}1
#===============================================================================

# vim: foldmethod=marker foldlevel=0
