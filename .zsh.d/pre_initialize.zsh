#===============================================================================
# Note: "{{{1
# pre_initialize.zsh
#
# Author: iyuuya <i.yuuya@gmail.com>
# }}}1
#===============================================================================

#===============================================================================
# PreInitialize: "{{{1

# mask
[[ $UID > 0 && $UID == $GID ]] && umask 002 || umask 022

# ls color (BSD)
export LSCOLORS=exfxcxdxbxegedabagacad
# default color theme for vim (iTerm)

case ${OSTYPE} in
  linux*)
    export TERM=xterm-256color
    ;;
esac

# "}}}1
#===============================================================================

# vim: foldmethod=marker foldlevel=0
