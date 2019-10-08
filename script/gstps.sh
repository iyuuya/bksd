gstps () {
  git subtree push --prefix="$1" "$1" master
}
gstps brew &
gstps git &
gstps node &
gstps nvim &
gstps ruby &
gstps tmux &
gstps zsh &
gstps vim &
wait
