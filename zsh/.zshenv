function src() {
  if [[ -s "$1" ]]; then
    source "$1"
  fi
}

src $HOME/.zsh.d/pre_initialize.zsh
src $HOME/.zsh.d/paths.zsh
src $HOME/.zsh.d/locale.zsh
src $HOME/.zsh.d/tools.zsh
src $HOME/.zsh.d/initialize.zsh
src $HOME/.zshenv.local

# vim: ft=zsh fdm=marker
# vim: et sw=2 sts=2 ts=2
