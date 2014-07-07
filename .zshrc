#===============================================================================
# Note: "{{{1
# .zshrc
#
# Author: iyuuya <i.yuuya@gmail.com>
# }}}1
#===============================================================================

#===============================================================================
# MacroFunction: "{{{1

# If the file exists then read.
function src() {
  if [[ -s "$1" ]]; then
    source "$1"
  fi
}

# "}}}1
#===============================================================================

#===============================================================================
# Configuration: "{{{1

src $HOME/.zsh.d/colors.zsh
src $HOME/.zsh.d/former.zsh
src $HOME/.zsh.d/aliases.zsh

function reset_db {
  bundle exec rake db:drop
  bundle exec rake db:create
  bundle exec rake db:migrate
  bundle exec rake db:seed_fu
  RAILS_ENV=test bundle exec rake db:migrate
}


# "}}}1
#===============================================================================

src $HOME/.zshrc.local

# vim: foldmethod=marker foldlevel=0
