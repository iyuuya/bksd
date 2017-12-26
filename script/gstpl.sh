gstpl () {
  git subtree pull --prefix $1 --message "Merge $1" $1 master
}
gstpl brew
gstpl git
gstpl node
gstpl nvim
gstpl ruby
gstpl ssh
gstpl tmux
gstpl zsh
gstpl vim
gstpl fish
