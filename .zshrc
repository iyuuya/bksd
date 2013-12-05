function src() {
  if [[ -s "$1" ]]; then
    source "$1"
  fi
}

[[ $UID > 0 && $UID = $GID ]] && umask 002 || umask 022

export LSCOLORS=exfxcxdxbxegedabagacad

# PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

src $HOME/.zsh.d/locale.zsh
src $HOME/.zsh.d/pager.zsh
src $HOME/.zsh.d/vi-mode.zsh
src $HOME/.zsh.d/rvm.zsh
src $HOME/.zsh.d/options.zsh

src $HOME/.zsh.d/former.zsh
PATH=~/bin:$PATH
src $HOME/.zsh.d/former.alias.zsh

