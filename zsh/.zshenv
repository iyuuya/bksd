#===============================================================================
# Note: "{{{1
# .zshenv
#
# Author: iyuuya <i.yuuya@gmail.com>
# }}}1
#===============================================================================

# profile
# zmodload zsh/zprof

#===============================================================================
# MacroFunction: "{{{1

# If the file exists then read.
function src() {
  if [[ -s "$1" ]]; then
    source "$1"
  fi
}

# "}}}1
#===============================================================================

#===============================================================================
# PreInitialize: "{{{1

# mask
[[ $UID > 0 && $UID == $GID ]] && umask 002 || umask 022

# ls color (BSD)
export LSCOLORS=exfxcxdxbxegedabagacad
# default color theme for vim (iTerm)

case ${OSTYPE} in
  darwin*)
    export TERM=xterm-256color
    ;;
  linux*)
    export TERM=xterm-256color
    ;;
esac

# "}}}1
#===============================================================================

#===============================================================================
# Path: "{{{1

# PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
case ${OSTYPE} in
  darwin*)
    typeset -U path
    path=(
      $HOME/bin(N-/)
      /usr/local/bin(N-/)
      /usr/local/share/git-core/contrib/diff-highlight(N-/)
      /usr/local/opt/imagemagick@6/bin(N-/)
      /usr/bin(N-/)
      /bin(N-/)
      /usr/X11/bin(N-/)
    )
    if [ -d $HOME/.anyenv ] ; then
      path=($HOME/.anyenv/bin(N-/) $path)
      for D in `ls $HOME/.anyenv/envs`; do
        path=(
          $HOME/.anyenv/envs/$D/bin(N-/)
          $HOME/.anyenv/envs/$D/shims(N-/)
          $path
        )
      done
    fi
    path=(
      $path
      /usr/local/sbin(N-/)
      /usr/sbin(N-/)
      /sbin(N-/)
    )
    ;;
esac

# man path
typeset -U manpath
manpath=({/usr/local,/usr}/share/man(N-/))

# pkg-config path
pkg_config_path=({/usr/local,/usr}/lib/pkgconfig(N-/))

# other path
case ${OSTYPE} in
  darwin*)
    export JAVA_HOME=$(/usr/libexec/java_home)
    #export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
    #export CLASSPATH=$CLASSPATH:$CATALINA_HOME/common/lib:$CATALINA_HOME/common/lib/servlet-api.jar
    #export CLASSPATH_PREFIX=$JAVA_HOME/jre/lib/mysql-connector-java-5.1.26-bin.jar
    export GRAPHVIZ_DOT=`brew --prefix`/bin/dot
    ;;
esac

# Android SDK
case ${OSTYPE} in
  darwin*)
    if [ -d /usr/local/share/android-sdk ]; then
      export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
      export ANDROID_HOME=/usr/local/share/android-sdk
    fi
    ;;
esac

# "}}}1
#===============================================================================

#===============================================================================
# Locale: "{{{1

case ${OSTYPE} in
  darwin*)
    export LANG=en_US.UTF-8
    export SECOND_LANG=ja_JP.UTF-8
    ;;
  linux*)
    export LANG=C
    export SECOND_LANG=ja_JP.UTF-8
    ;;
  *)
    export LANG=C
    ;;
esac

export LC_TIME=C

# Switch locale
function swlc() {
  if [ -n "$SECOND_LANG" ]; then
    tmp_lang=$LANG
    export LANG=$SECOND_LANG
    export SECOND_LANG=$tmp_lang
    locale
  fi
}

# "}}}1
#===============================================================================

#===============================================================================
# Pager: "{{{1

if type lv > /dev/null 2>&1; then
  export PAGER="lv"
else
  export PAGER="less"
fi

# if type vimpager > /dev/null 2>&1; then
#   export PAGER="vimpager"
# fi

if [ "$PAGER" = "lv" ]; then
  export LV="-c -l"
fi

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
# editor: "{{{1

export EDITOR=nvim
export BUNDLE_EDITOR=$EDITOR

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

# "}}}1
#===============================================================================

#===============================================================================
# Initialize: "{{{1

case ${OSTYPE} in
  linux*)
    export LIBGL_ALWAYS_INDIRECT=1
    ;;
  darwin*)
    export COLORTERM=truecolor
    ;;
esac

export GPG_TTY=$(tty)

# "}}}1
#===============================================================================

src $HOME/.zshenv.local

# vim: ft=zsh fdm=marker et sw=2 sts=2 ts=2
