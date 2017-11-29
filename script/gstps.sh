gstps () {
  git subtree push --prefix="$1" "$1" master
}
gstps brew &
gstps git &
gstps node &
gstps nvim &
gstps ruby &
gstps ssh &
gstps tmux &
gstps zsh &
gstps vim &
gstps fish &
wait
