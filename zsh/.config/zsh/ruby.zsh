# bundle:
alias -g RT='RAILS_ENV=test'

alias b='bundle'
alias bi='b install'
alias be='b exec'
alias bu='b update'
if type peco > /dev/null 2>&1; then
  alias bs='bundle show `bundle-gemname-list | peco`'
  alias bo='bundle open `bundle-gemname-list | peco`'
fi

# rbenv:
alias rb='rbenv'
compctl -K _rbenv rb
alias rbv='rbenv version'
alias rbvs='rbenv versions'
alias rbg='rbenv global'
alias rbl='rbenv local'
alias rbr='rbenv rehash'

# rake:
alias rk='rake'
alias rkt='rake -T'

# rails:
alias bb='bin/bundle'
alias bbe='bin/bundle exec'
alias bbi='bin/bundle install'
alias bbu='bin/bundle update'
alias rr='bin/rails'
alias ra='bin/rake'
alias rp='bin/rspec'
alias rs='bin/spring'
alias ru='bin/rubocop'

# ctags:

alias rtags='ctags --langmap=RUBY:.rb --exclude="*.js" --exclude=".git*" -R'

alias mux='tmuxinator'

# Rubocop default options
export RUBOCOP_OPTS='-D -S -E'
# -D, --display-cop-names    Display cop names in offense messages.
# -E, --extra-details        Display extra details in offense messages.
# -S, --display-style-guide  Display style guide URLs in offense messages.
