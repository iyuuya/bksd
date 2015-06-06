if type peco > /dev/null 2>&1; then
  alias -g P='| peco'

  alias bs='bundle show `bundle-gemname-list | peco`'
  alias bo='bundle open `bundle-gemname-list | peco`'

  function peco-select-history() {
    local tac
    if which tac > /dev/null; then
      tac='tac'
    else
      tac='tail -r'
    fi
    BUFFER=$(history -n 1 | \
      eval $tac | \
      peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
  }
  zle -N peco-select-history
  bindkey '^r' peco-select-history

  function ghq-list-relative () {
    local query
    if [ $# = 1 ]; then
      query=$1
    else
      query=''
    fi
    ghq list $query -p | sed -e "s/$(echo $HOME | sed -e 's/\//\\\//g')/~/g"
  }

  function peco-src () {
    local list
    if [ $# = 1 ]; then
      list=$(ghq-list-relative $1)
    else
      list=$(ghq-list-relative)
    fi
    local selected_dir=$(echo $list | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
      BUFFER="cd ${selected_dir}"
      zle accept-line
    fi
    zle clear-screen
  }
  zle -N peco-src
  bindkey '^gg' peco-src

  function peco-my-src () {
    peco-src $USER
  }
  zle -N peco-my-src
  bindkey '^gm' peco-my-src

  function peco-select-branch() {
      local current_buffer=$BUFFER

      local selected_line="$(git for-each-ref --format='%(refname:short) | %(committerdate:relative) | %(committername) | %(subject)' --sort=-committerdate refs/heads refs/remotes \
          | column -t -s '|' \
          | peco \
          | head -n 1 \
          | awk '{print $1}')"
      if [ -n "$selected_line" ]; then
          BUFFER="${current_buffer} ${selected_line}"
          CURSOR=$#BUFFER
          # ↓そのまま実行の場合
          #zle accept-line
      fi
      zle clear-screen
  }
  zle -N peco-select-branch
  bindkey '^gb' peco-select-branch

  function peco-cd() {
    local selected_line="$(ls -aF | grep / | peco)"
    if [ -n "$selected_line" ]; then
      cd $selected_line
      # zle accept-line
      peco-cd
    fi
    # zle clear-screen
  }
  alias pcd=peco-cd

  # peco-cd-vim-neomru
  function peco-vim-neomru() {
    local mru_path="~/.cache/neomru/directory"
    local SELECTED=$(eval more $mru_path | peco --query "$1")
    if [ 0 -ne ${#SELECTED} ]; then
      eval cd $SELECTED
    fi
  }
  alias pvd=peco-vim-neomru
fi
