[[ $UID > 0 && $UID = $GID ]] && umask 002 || umask 022

export LSCOLORS=exfxcxdxbxegedabagacad

PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

function src() {
  if [[ -s "$1" ]]; then
    source "$1"
  fi
}

src $HOME/.zsh.d/locale.zsh
src $HOME/.zsh.d/pager.zsh
src $HOME/.zsh.d/vi-mode.zsh
src $HOME/.zsh.d/rvm.zsh
