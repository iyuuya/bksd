function _peco_insert_command_line() {
  if zle; then
    BUFFER=$1
    CUSOR=$#BUFFER
    zle clear-screen
  else
    print -z $1
  fi
}

function peco-ghq() {
  local selected
  selected=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected" ]; then
    _peco_insert_command_line "cd $selected"
    zle accept-line
  fi
}

function peco-ghq-my() {
  LBUFFER=$USER
  peco-ghq
}

function peco-history() {
  local selected tailr
  if which "tac" > /dev/null 2>&1; then
    tailr="tac"
  else
    tailr="tail -r"
  fi
  selected=$(fc -l -n 1 | eval $tailr | peco)
  _peco_insert_command_line $selected
  zle accept-line
}

function peco-git-branch() {
  local selected="$(git for-each-ref --format='%(refname:short) | %(committerdate:relative) | %(committername) | %(subject)' --sort=-committerdate refs/heads refs/remotes \
      | column -t -s '|' \
      | peco \
      | head -n 1 \
      | awk '{print $1}')"
  _peco_insert_command_line $selected
}

function peco-git-checkout() {
  local selected
  local branch=$(git branch -a | peco | tr -d ' ')
  if [ -n "$branch" ]; then
    if [[ "$branch" =~ "remotes/" ]]; then
      local b=$(echo $branch | awk -F'/' '{print $3}')
      selected="git checkout -b '${b}' '${branch}'"
    else
      selected="git checkout '${branch}'"
    fi
  fi
  _peco_insert_command_line $selected
  zle accept-line
}

function peco-cd() {
  local selected="$(ls -aF | grep / | peco)"
  if [ -n "$selected" ]; then
    cd $selected
    peco-cd
  fi
}

function peco-git-log() {
  local selected
  selected=$(git log --oneline --decorate=full | peco | awk '{print $1}')
  if [ -n  "$selected" ]; then
    BUFFER=$selected
    zle clear-screen
  fi
}

function peco-vim-neomru() {
  local mru_path="~/.cache/neomru/directory"
  local SELECTED=$(eval more $mru_path | peco --query "$1")
  if [ 0 -ne ${#SELECTED} ]; then
    eval cd $SELECTED
  fi
}

function peco-xdg-config() {
  local selected_dir=$(ls -L ~/.config/ | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ~/.config/${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}

function peco-tmux-session() {
  local selected
  selected=$(tmux list-sessions | peco | awk -F':' '{print $1}')
  if [ -n "$selected" ]; then
    if [ -n "$TMUX" ]; then
      _peco_insert_command_line "tmux switch-client -t $selected"
    else
      _peco_insert_command_line "tmux attach -t $selected"
    fi
    zle accept-line
    zle clear-screen
  fi
}

function peco-rbenv-shell() {
  local selected
  selected=$(rbenv versions --bare | peco)
  if [ -n "$selected" ];then
    BUFFER="rbenv shell ${selected}"
    zle accept-line
  fi
  zle clear-screen
}

function peco-rbenv-install() {
  local selected
  selected=$(rbenv install -l -s | sed -e '1d' | peco)
  if [ -n "$selected" ]; then
    BUFFER="rbenv install ${selected}"
    zle accept-line
  fi
  zle clear-screen
}

function peco-ndenv-shell() {
  local selected
  selected=$(ndenv versions --bare | peco)
  if [ -n "$selected" ];then
    BUFFER="ndenv shell ${selected}"
    zle accept-line
  fi
  zle clear-screen
}

function peco-ndenv-install() {
  local selected
  selected=$(ndenv install -l | grep -v 'iojs' | sed -e '1d' -e 's/v//' | peco)
  if [ -n "$selected" ]; then
    BUFFER="ndenv install ${selected}"
    zle accept-line
  fi
  zle clear-screen
}

alias -g P='| peco'
alias pcd=peco-cd
alias pvd=peco-vim-neomru

zle -N peco-history
zle -N peco-ghq
zle -N peco-ghq-my
zle -N peco-git-log
zle -N peco-git-branch
zle -N peco-git-checkout
zle -N peco-tmux-session
zle -N peco-xdg-config
zle -N peco-rbenv-shell
zle -N peco-rbenv-install
zle -N peco-ndenv-shell
zle -N peco-ndenv-install

bindkey '^r'  peco-history
bindkey '^gg' peco-ghq
bindkey '^gm' peco-ghq-my
bindkey '^gl' peco-git-log
bindkey '^gb' peco-git-branch
bindkey '^gc' peco-git-checkout
bindkey '^gf' peco-xdg-config
bindkey '^ts' peco-tmux-session
bindkey '^rs' peco-rbenv-shell
bindkey '^ri' peco-rbenv-install
bindkey '^ns' peco-ndenv-shell
bindkey '^ni' peco-ndenv-install

function peco-bindkeys() {
  echo '^r  peco-history'
  echo '^gg peco-ghq'
  echo '^gm peco-ghq-my'
  echo '^gl peco-git-log'
  echo '^gb peco-git-branch'
  echo '^gc peco-git-checkout'
  echo '^gf peco-xdg-config'
  echo '^ts peco-tmux-session'
  echo '^rs peco-rbenv-shell'
  echo '^ri peco-rbenv-install'
  echo '^rs peco-ndenv-shell'
  echo '^ri peco-ndenv-install'
}
