autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u%b%f:"
zstyle ':vcs_info:*' actionformats '%b|%a'

# Autoload _git completion functions
# if declare -f _git > /dev/null; then
#   _git
# fi

if declare -f _git_commands > /dev/null; then
  _hub_commands=(
    'alias:show shell instructions for wrapping git'
    'pull-request:open a pull request on GitHub'
    'fork:fork origin repo on GitHub'
    'create:create new repo on GitHub for the current project'
    'browse:browse the project on GitHub'
    'compare:open GitHub compare view'
  )
  # Extend the '_git_commands' function with hub commands
  eval "$(declare -f _git_commands | sed -e 's/base_commands=(/base_commands=(${_hub_commands} /')"
fi

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

function git-rewrite-author()
{
  if [ $# = 0 ]
  then
    echo 'usage: git-rewrite-author old_name new_name new_email range'
    return
  fi

  local old_name=$1
  local new_name=$2
  local new_email=$3
  local range=$4

  git filter-branch --commit-filter "
    if [ \"\$GIT_COMMITTER_NAME\" = \"$old_name\" ];
    then
      GIT_COMMITTER_NAME=\"$new_name\";
      GIT_AUTHOR_NAME=\"$new_name\";
      GIT_COMMITTER_EMAIL=\"$new_email\";
      GIT_AUTHOR_EMAIL=\"$new_email\";
      git commit-tree \"\$@\";
    else
      git commit-tree \"\$@\";
    fi" $range
}

function git-rewrite-author2()
{
  git filter-branch -f --env-filter "GIT_AUTHOR_NAME='$1'; GIT_AUTHOR_EMAIL='$2'; GIT_COMMITTER_NAME='$1'; GIT_COMMITTER_EMAIL='$2';" $3
}

if type hub > /dev/null 2>&1; then
  alias git='hub'
fi

alias g='git'
compdef g=git

alias gl="g log --graph --pretty=format:'%Cblue%h%Creset%d %Cgreen%an%Creset: %s %Cblue%ar%Creset'"
alias gc='g commit'
alias gcm='g commit -m'
alias gco='g checkout'
alias grs='g reset'
alias gd='g diff'
alias ga='g add'
alias gs='g status'
alias gpl='g pull'
alias gps='g push'
alias gsm='g submodule'
alias gst='g subtree'
alias gsu="g submodule foreach 'git checkout master; git pull'"
alias grmal='git ls-files -z --deleted | xargs -0 git rm'
alias tiga='tig --all'

case ${OSTYPE} in
  darwin*)
    alias gnw=/usr/local/opt/git/share/git-core/contrib/workdir/git-new-workdir
    ;;
esac
