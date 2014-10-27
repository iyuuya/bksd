#===============================================================================
# Note: "{{{1
# .zshrc
#
# Author: iyuuya <i.yuuya@gmail.com>
# }}}1
#===============================================================================

#===============================================================================
# Path: "{{{1

# PATH

# Does not register a duplicate PATH.
# typeset -U path
# 
# path=(
#   # ~/bin
#   $HOME/bin(N-/)
#   # Homebrew
#   $HOME/brew/bin(N-/)
#   # rbenv
#   $HOME/.rbenv/bin(N-/)
#   # rvm
#   $HOME/.rvm/bin(N-/)
#   # cabal
#   $HOME/.cabal/bin(N-/)
#   # System
#   {/usr/local,/usr/local/share/npm,/usr,}/bin(N-/)
#   # Mac
#   /usr/X11/bin(N-/)
# )
# 
# # SUDO_PATH
# typeset -xT SUDO_PATH sudo_path
# typeset -U sudo_path
# sudo_path=({,/usr/local,/usr}/sbin(N-/))
# 
# PATH=$PATH:$SUDO_PATH
# 

# PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
PATH=$HOME/bin:/usr/local/bin:/usr/local/share/npm/bin:/usr/bin:/bin:/usr/X11/bin:$PATH
PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin
export PATH

# man path
typeset -U manpath
manpath=({/usr/local,/usr}/share/man(N-/))

# pkg-config path
pkg_config_path=({/usr/local,/usr}/lib/pkgconfig(N-/))

# other path
case ${OSTYPE} in
  darwin*)
    export NODE_PATH=/usr/local/lib/node
    export VIM_APP_DIR=$HOME/Applications
    # export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
    export JAVA_HOME=$(/usr/libexec/java_home)
    export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
    export CLASSPATH=$CLASSPATH:$CATALINA_HOME/common/lib:$CATALINA_HOME/common/lib/servlet-api.jar
    export CLASSPATH_PREFIX=$JAVA_HOME/jre/lib/mysql-connector-java-5.1.26-bin.jar
    export GRAPHVIZ_DOT=`brew --prefix`/bin/dot
    ;;
esac

if [ -d $HOME/.anyenv ] ; then
  export PATH=$HOME/.anyenv/bin:$PATH
  eval "$(anyenv init -)"
  for D in `ls $HOME/.anyenv/envs`
  do
    export PATH=$HOME/.anyenv/envs/$D/shims:$PATH
  done
fi

# "}}}1
#===============================================================================

# vim: foldmethod=marker foldlevel=0
