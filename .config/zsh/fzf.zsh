if [ -x "`which fzf`" ] && [ -x "`which ag`" ]; then
  export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
  export FZF_DEFAULT_OPTS='--height 60% --reverse --border --ansi --select-1 --extended --cycle'
fi

function _fzf_insert_command_line() {
  if zle; then
    BUFFER=$1
    CUSOR=$#BUFFER
    zle clear-screen
  else
    print -z $1
  fi
}

function fzf-ghq() {
  local selected
  selected=$(ghq list -p | fzf --preview 'ls {}' --query "$LBUFFER")
  if [ -n "$selected" ]; then
    _fzf_insert_command_line "cd $selected"
    zle accept-line
  fi
}

function fzf-ghq-my() {
  LBUFFER=$USER
  fzf-ghq
}

function fzf-history() {
  local selected tailr
  if which "tac" > /dev/null 2>&1; then
    tailr="tac"
  else
    tailr="tail -r"
  fi
  selected=$(fc -l -n 1 | eval $tailr | fzf)
  _fzf_insert_command_line $selected
  zle accept-line
}

function fzf-git-branch() {
  local selected="$(git for-each-ref --format='%(refname:short) | %(committerdate:relative) | %(committername) | %(subject)' --sort=-committerdate refs/heads refs/remotes \
      | column -t -s '|' \
      | fzf \
      | head -n 1 \
      | awk '{print $1}')"
  _fzf_insert_command_line $selected
}

function fzf-git-checkout() {
  local selected
  local branch=$(git branch -a | fzf | tr -d ' ')
  if [ -n "$branch" ]; then
    if [[ "$branch" =~ "remotes/" ]]; then
      local b=$(echo $branch | awk -F'/' '{print $3}')
      selected="git checkout -b '${b}' '${branch}'"
    else
      selected="git checkout '${branch}'"
    fi
  fi
  _fzf_insert_command_line $selected
  zle accept-line
}

function fzf-cd() {
  local selected="$(ls -aF | grep / | fzf)"
  if [ -n "$selected" ]; then
    cd $selected
    fzf-cd
  fi
}

function fzf-git-log() {
  local selected
  selected=$(git log --oneline --decorate=full | fzf | awk '{print $1}')
  if [ -n  "$selected" ]; then
    BUFFER=$selected
    zle clear-screen
  fi
}

function fzf-vim-neomru() {
  local mru_path="~/.cache/neomru/directory"
  local SELECTED=$(eval more $mru_path | fzf --query "$1")
  if [ 0 -ne ${#SELECTED} ]; then
    eval cd $SELECTED
  fi
}

function fzf-xdg-config() {
  local selected_dir=$(ls -L ~/.config/ | fzf --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ~/.config/${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}

function fzf-tmux-session() {
  local selected
  selected=$(tmux list-sessions | fzf | awk -F':' '{print $1}')
  if [ -n "$selected" ]; then
    if [ -n "$TMUX" ]; then
      _fzf_insert_command_line "tmux switch-client -t $selected"
    else
      _fzf_insert_command_line "tmux attach -t $selected"
    fi
    zle accept-line
    zle clear-screen
  fi
}

function fzf-rbenv-shell() {
  local selected
  selected=$(rbenv versions --bare | fzf)
  if [ -n "$selected" ];then
    BUFFER="rbenv shell ${selected}"
    zle accept-line
  fi
  zle clear-screen
}

function fzf-rbenv-install() {
  local selected
  selected=$(rbenv install -l -s | sed -e '1d' | fzf)
  if [ -n "$selected" ]; then
    BUFFER="rbenv install ${selected}"
    zle accept-line
  fi
  zle clear-screen
}

function fzf-nodenv-shell() {
  local selected
  selected=$(nodenv versions --bare | fzf)
  if [ -n "$selected" ];then
    BUFFER="nodenv shell ${selected}"
    zle accept-line
  fi
  zle clear-screen
}

function fzf-nodenv-install() {
  local selected
  selected=$(nodenv install -l | grep -v 'iojs' | sed -e '1d' -e 's/v//' | fzf)
  if [ -n "$selected" ]; then
    BUFFER="nodenv install ${selected}"
    zle accept-line
  fi
  zle clear-screen
}

function fzf-go-src() {
  local selected
  selected=$(find $(go env GOPATH)/src -type d -depth 3 | grep github | fzf --preview 'ls {}' --query "$LBUFFER")
  if [ -n "$selected" ]; then
    _fzf_insert_command_line "cd $selected"
    zle accept-line
  fi
}

alias -g P='| fzf'
alias pcd=fzf-cd
alias pvd=fzf-vim-neomru

zle -N fzf-history
zle -N fzf-ghq
zle -N fzf-ghq-my
zle -N fzf-go-src
zle -N fzf-git-log
zle -N fzf-git-branch
zle -N fzf-git-checkout
zle -N fzf-tmux-session
zle -N fzf-xdg-config
zle -N fzf-rbenv-shell
zle -N fzf-rbenv-install
zle -N fzf-nodenv-shell
zle -N fzf-nodenv-install

bindkey '^r'  fzf-history
bindkey '^gg' fzf-ghq
bindkey '^gm' fzf-ghq-my
bindkey '^go' fzf-go-src
bindkey '^gl' fzf-git-log
bindkey '^gb' fzf-git-branch
bindkey '^gc' fzf-git-checkout
bindkey '^gf' fzf-xdg-config
bindkey '^ts' fzf-tmux-session
bindkey '^rs' fzf-rbenv-shell
bindkey '^ri' fzf-rbenv-install
bindkey '^ns' fzf-nodenv-shell
bindkey '^ni' fzf-nodenv-install

function fzf-bindkeys() {
  echo '^r  fzf-history'
  echo '^gg fzf-ghq'
  echo '^gm fzf-ghq-my'
  echo '^go fzf-go-src'
  echo '^gl fzf-git-log'
  echo '^gb fzf-git-branch'
  echo '^gc fzf-git-checkout'
  echo '^gf fzf-xdg-config'
  echo '^ts fzf-tmux-session'
  echo '^rs fzf-rbenv-shell'
  echo '^ri fzf-rbenv-install'
  echo '^ns fzf-nodenv-shell'
  echo '^ni fzf-nodenv-install'
}
