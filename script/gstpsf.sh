function gstpsf () {
  git push $1 `git subtree split --prefix $1 master`:master --force
}
gstps brew &
gstps git &
gstps mysql &
gstps node &
gstps nvim &
gstps ruby &
gstps ssh &
gstps tmux &
gstps zsh &
wait
