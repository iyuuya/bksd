gstpsf () {
  git push "$1" "$(git subtree split --prefix "$1" master)":master --force
}
gstpsf brew &
gstpsf git &
gstpsf node &
gstpsf nvim &
gstpsf ruby &
gstpsf tmux &
gstpsf zsh &
gstpsf vim &
wait
