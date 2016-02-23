# BSD(Mac)
function git-grep-replace() {
  if [ $# != 2 ]; then
    echo "usage: git-grep-replace search_word replace-regex"
    return
  fi
  git grep -l $1 | xargs sed -i '' -e "$2"
}

function success-snap() {
  bundle exec rspec $target
  if [ $? -eq 0 ]; then
    git add .
    git commit -m "[wip] success snap"
  fi
}
alias ss=success-snap
