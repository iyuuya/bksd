function gstpsf () {
  git push $1 `git subtree split --prefix $1 master`:master --force
}
gstpsf brew
gstpsf git
gstpsf nvim
gstpsf ruby
gstpsf ssh
gstpsf tmux
gstpsf zsh
