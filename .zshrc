#===============================================================================
# Note: "{{{1
# .zshrc
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

#===============================================================================
# Environment: "{{{1

src $HOME/.zsh.d/pre_initialize.zsh
src $HOME/.zsh.d/locale.zsh
src $HOME/.zsh.d/paths.zsh
src $HOME/.zsh.d/tools.zsh
src $HOME/.zsh.d/initialize.zsh
src $HOME/.zsh.d/colors.zsh
src $HOME/.nvm/nvm.sh
src /opt/boxen/env.sh
export PATH=$HOME/brew/bin:$PATH

if [ -d $HOME/.anyenv ] ; then
  export PATH=$HOME/.anyenv/bin:$PATH
  eval "$(anyenv init -)"
  for D in `ls $HOME/.anyenv/envs`
  do
    export PATH=$HOME/.anyenv/envs/$D/shims:$PATH
  done
fi
src $HOME/.zshenv.local

# "}}}1
#===============================================================================

#===============================================================================
# Configuration: "{{{1

src $HOME/.zsh.d/former.zsh
src $HOME/.zsh.d/tmuxinator.zsh
src $HOME/.zsh.d/aliases.zsh

# "}}}1
#===============================================================================

# vim: foldmethod=marker foldlevel=0
