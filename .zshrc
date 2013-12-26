function src() {
  if [[ -s "$1" ]]; then
    source "$1"
  fi
}

# PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

src $HOME/.zsh.d/former.zsh
export PATH=$HOME/bin:$HOME/.rvm/bin:/usr/local/bin:/usr/local/share/npm/bin:/usr/bin:/bin:/usr/X11/bin
# src $HOME/.zsh.d/locale.zsh
# src $HOME/.zsh.d/pager.zsh
# src $HOME/.zsh.d/vi-mode.zsh
# src $HOME/.zsh.d/options.zsh
src $HOME/.zsh.d/rvm.zsh
src $HOME/.zsh.d/former.alias.zsh
