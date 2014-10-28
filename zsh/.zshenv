#===============================================================================
# Note: "{{{1
# .zshenv
#
# Author: iyuuya <i.yuuya@gmail.com>
# }}}1
#===============================================================================

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

src $HOME/.zsh.d/pre_initialize.zsh
src $HOME/.zsh.d/paths.zsh
src $HOME/.zsh.d/locale.zsh
src $HOME/.zsh.d/tools.zsh
src $HOME/.zsh.d/initialize.zsh
src $HOME/.zshenv.local

# vim: ft=zsh fdm=marker et sw=2 sts=2 ts=2
