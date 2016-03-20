function gstps () {
  git subtree push --prefix=$1 $1 master
}
gstps vim
gstps nvim
gstps zsh
gstps git
gstps tmux
gstps ruby
gstps brew
