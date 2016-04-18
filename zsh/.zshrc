#===============================================================================
# Note: "{{{1
# .zshrc
#
# Author: iyuuya <i.yuuya@gmail.com>
# }}}1
#===============================================================================

[ -f ~/.anyenv/bin/anyenv ] && eval "$(anyenv init - zsh)"

source ~/.config/zsh/options.zsh

autoload -U compinit
compinit -C

case ${OSTYPE} in
  darwin*)
    fpath=(
      /usr/local/share/zsh-completions(N-/)
      $HOME/brew/share/zsh-completions(N-/)
      $HOME/.config/zsh/functions/*(N-/)
      $fpath
    )
    ;;
esac

cdpath=($HOME)
chpwd_functions=($chpwd_functions dirs)

source $HOME/.config/zsh/git.zsh

if type go > /dev/null 2>&1; then
  source $HOME/.config/zsh/go.zsh
fi
if type peco > /dev/null 2>&1; then
  source $HOME/.config/zsh/peco.zsh
fi
source $HOME/.config/zsh/ruby.zsh

#===============================================================================
# Prompting: "{{{1

#-------------------------------------------------------------------------------
# rbenv-prompt: "{{{2
function rbenv_prompt {
  if type rbenv > /dev/null 2>&1; then
    result=`rbenv version-name`
    if [ "$result" ] ; then
      echo "$result"
    else
      echo "rbenv"
    fi
  else
    echo ""
  fi
}
# }}}2
#-------------------------------------------------------------------------------

## return prompt format expand characters count (not support Japanese)
function count_prompt_characters()
{
  print -n -P -- "$1" | sed -e $'s/\e\[[0-9;]*m//g' | wc -m | sed -e 's/ //g'
}

#-------------------------------------------------------------------------------

function update_prompt() # "{{{2
{
  # user@host(2012/03/04 05:06)[1.9.3]>>-: "{{{3
  # user@host
  bar_left_self="%{%F{green}%}%n%{%F{yellow}%}@%{%F{red}%}%m%{%f%}"
  # date: (2012/03/04 05:06)
  bar_left_date="(%D{%Y/%m/%d %H:%M:%S})"
  # rbenv : [1.9.3]
  if [ -n "$(rbenv_prompt)" ]; then
    bar_left_ruby="[%{%F{red}%}$(rbenv_prompt)%{%f%}]"
  fi

  # local bar_left="${bar_left_self}${bar_left_date}${bar_left_ruby}${bar_left_node}${bar_left_python}${bar_left_go}${bar_left_scala}>>-"
  local bar_left="${bar_left_self}${bar_left_date}${bar_left_ruby}"
  # "}}}3

  # ----<master:project>-<<: "{{{3
  prompt_bar_right='${vcs_info_msg_0_}'
  # LANG=C vcs_info >&/dev/null
  # if [ -n "$(git_prompt)" ]; then
  #   prompt_bar_right="$(git_prompt):"
  # fi
  # -<master:project>
  prompt_bar_right="[${prompt_bar_right}%{%F{yellow}%}%c%{%f%}]"

  local bar_right_without_path="${prompt_bar_right:s/%d//}"
  local bar_right_without_path_length=$(count_prompt_characters "$bar_right_without_path")
  bar_right=${prompt_bar_right:s/%d/%(C,%<...<%d%<<,)/}

  # "}}}3

  local prompt_left="%#%{%b%} "

  # user@host(2012/03/04 05:06)[1.9.3]>>-----<master:project>-<<
  # % 
  PROMPT="${bar_left}${bar_right}"$'\n'"${prompt_left}"
  RPROMPT="[%{%B%F{magenta}%}%~%{%f%b%}]"
  SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
}
# "}}}2
#-------------------------------------------------------------------------------

function update_tmux_pwd()
{
  $([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")
}

precmd_functions=($precmd_functions vcs_info update_prompt update_tmux_pwd)

# "}}}1
#===============================================================================

#===============================================================================
# Completion: "{{{1

## Initialize

## Grouping completion
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''

zstyle ':completion:*:default' menu select interactive

zstyle ':completion:*:default' list-colors ""

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'

zstyle ':completion:*' completter \
  _oldlist _complete _match _history _ignored _approximate _prefix

zstyle ':completion:*' use-cache yes

zstyle ':completion:*' varbose yes

zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

# "}}}1
#===============================================================================

#===============================================================================
# History: "{{{1

HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=$HISTSIZE

autoload history-search-end

# "}}}1
#===============================================================================

#===============================================================================
# Others: "{{{1

REPORTTIME=3

watch="all"
log

WORDCHARS=${WORDCHARS:s,/,,}
WORDCHARS="${WORDCHARS}|"

function ztime {
  time (zsh -i -c exit)
}

# "}}}1
#===============================================================================

#===============================================================================
# Key Bind: "{{{1

bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# "}}}1
#===============================================================================

#===============================================================================
# Function: "{{{1

autoload -Uz reload
autoload -Uz search
autoload -Uz benchmark
autoload -Uz b100
autoload -Uz switch-user
alias sw=switch-user
autoload -Uz ghq-update
autoload -Uz bundle-gemname-list
autoload -Uz db_reset

# "}}}1
#===============================================================================

#===============================================================================
# Alias: "{{{1

alias lv="$PAGER"
alias less="$PAGER"

if type ccat > /dev/null 2>&1; then
  alias cat='ccat'
fi

if type colordiff > /dev/null 2>&1; then
  alias diff='colordiff'
fi

if type dfc > /dev/null 2>&1; then
  alias df='dfc'
fi

if type gsed > /dev/null 2>&1; then
  alias sed=gsed
fi

# global: "{{{2

alias -g L='|& $PAGER -R'
alias -g G='| grep'
alias -g C='| cat -n'
alias -g H='| head'
alias -g T='| tail'
alias -g A='| awk'
alias -g S='| sed'
alias -g W='| wc'
alias -g D='> /dev/null 2>&1'

alias -g JQ="| jq '.'"

# "}}}2

alias ls='ls -GF'
alias l='ls'
alias ll='l -lh'
alias la='l -a'
alias lf='l | grep /'
alias dir='l -al'

alias lns='ln -s'
alias rmr='rm -rf'

alias pd='pushd'
alias po='popd'

alias where='command -v'

alias x='exit'

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi
alias v='nvim'
compdef v=nvim

if type /usr/local/Cellar/emacs/24.3/Emacs.app/Contents/MacOS/Emacs > /dev/null 2>&1; then
  alias emacs="/usr/local/Cellar/emacs/24.3/Emacs.app/Contents/MacOS/Emacs -nw"
fi
alias em=emacs

# docker: "{{{2

# alias d='docker'
# compdef d=docker
alias dm='docker-machine'
alias b2d='boot2docker'
_boot2docker() {
  local context state line

  _arguments -C \
    --basevmdk'[Path to VMDK to use as base for persistent partition]:vmdk:' \
    --dhcp'[enable VirtualBox host-only network DHCP. default=true]' \
    --dhcpip'[VirtualBox host-only network DHCP server address. default=192.168.59.99]' \
    '(-s --disksize)'{-s,--disksize}'[boot2docker disk image size (in MB). default=20000.]:disksize:' \
    --dockerport'[host Docker port (forward to port 2375 in VM).]:PORT:' \
    --hostip'[VirtualBox host-only network IP address.]:IP:' \
    --iso'[path to boot2docker ISO image.]:FILE:_files' \
    --lowerip'[VirtualBox host-only network DHCP lower bound.]:IP:' \
    '(-m --memory)'{-m,--memory}'[virtual machine memory size (in MB). default=2048]' \
    --netmask'[VirtualBox host-only network mask.]' \
    --serial'[try serial console to get IP address (experimental) default=false]' \
    --serialfile'[path to the serial socket/pipe.]:FILE:_files' \
    --ssh'[path to SSH client utility. default="ssh"]:SSH:' \
    --ssh-keygen'[path to ssh-keygen utility. default="ssh-keygen"]:KEYGEN:' \
    --sshkey'[path to SSH key to use.]:FILE:_files' \
    --sshport'[host SSH port (forward to port 22 in VM). default=2022]:PORT:' \
    --upperip'[VirtualBox host-only network DHCP upper bound. default=192.168.59.254]:IP:' \
    --vbm'[path to VirtualBox management utility. default="VBoxManage"]' \
    '(-v --verbose)'{-v,--verbose}'[display verbose command invocations. default=false]' \
    --vm'[virtual machine name. default="boot2docker-vm"]' \
    '*::boot2docker commands:_boot2docker_command'
}

# }}}2

alias nko='nkf --overwrite'
alias tree='tree -N'
alias s='search'

# Applicatioin alias
function app_alias()
{
  local APP=$1
  shift
  for i in $@; do;
    alias -s $i=${APP}
  done;
}

app_alias nvim c cpp cc h cs \
  rb rake ru erb haml slim html php \
  js jsx ts coffee json jade css scss sass \
  mkd md asciidoc adoc asc textile rdoc creole txt csv go \
  py pl hs lhs sql conf toml yaml yml y

if type /Applications/Gyazo.app/Contents/MacOS/Gyazo> /dev/null 2>&1; then
  alias gyazo='/Applications/Gyazo.app/Contents/MacOS/Gyazo "$@"'
fi
if type ~/Applications/Gyazo.app/Contents/MacOS/Gyazo> /dev/null 2>&1; then
  alias gyazo='~/Applications/Gyazo.app/Contents/MacOS/Gyazo "$@"'
fi

if type tmux > /dev/null 2>&1; then
  alias t='tmux'
  compdef t=tmux
  alias tns='tmux new-session -s'
  alias tat='tmux attach-session -t'
  alias tls='tmux list-sessions'
  alias tks='tmux kill-session -t'
  alias sp='tmux split-window'
  alias vs='tmux split-window -h'
fi

if type ~/Applications/Shoes.app/Contents/MacOS/shoes > /dev/null 2>&1; then
  alias shoes='~/Applications/Shoes.app/Contents/MacOS/shoes "$@"'
fi

# added by travis gem
src $HOME/.travis/travis.sh

# "}}}1
#===============================================================================

src $HOME/.zshrc.local

if type zprof > /dev/null 2>&1; then
  zprof | less
fi
# vim: ft=zsh fdm=marker et sw=2 sts=2 ts=2
