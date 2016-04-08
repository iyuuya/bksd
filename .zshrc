#===============================================================================
# Note: "{{{1
# .zshrc
#
# Author: iyuuya <i.yuuya@gmail.com>
# }}}1
#===============================================================================

src ~/.zsh.d/options.zsh

autoload -U compinit
compinit

case ${OSTYPE} in
  darwin*)
    fpath=(
      /usr/local/share/zsh-completions(N-/)
      $HOME/brew/share/zsh-completions(N-/)
      $HOME/.zsh.d/functions/*(N-/)
      $fpath
    )
    ;;
esac

cdpath=($HOME)
chpwd_functions=($chpwd_functions dirs)

src $HOME/.zsh.d/git.zsh

if type go > /dev/null 2&>1; then
  src $HOME/.zsh.d/go.zsh
fi
if type ghq > /dev/null 2>&1; then
  src $HOME/.zsh.d/ghq.zsh
fi
if type peco > /dev/null 2>&1; then
  src $HOME/.zsh.d/peco.zsh
fi
src $HOME/.zsh.d/ruby.zsh

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

#-------------------------------------------------------------------------------
# pyenv-prompt: "{{{2
function pyenv_prompt {
  if type pyenv > /dev/null 2>&1; then
    result=`pyenv version-name`
    if [ "$result" ] ; then
      echo "$result"
    else
      echo "pyenv"
    fi
  else
    echo ""
  fi
}
# }}}2
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# ndenv-prompt: "{{{2
function ndenv_prompt {
  if type ndenv > /dev/null 2>&1; then
    result=`ndenv version-name`
    if [ "$result" ] ; then
      echo "$result"
    else
      echo "ndenv"
    fi
  else
    echo ""
  fi
}
# }}}2
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# scalaenv-prompt: "{{{2
function scalaenv_prompt {
  if type scalaenv > /dev/null 2>&1; then
    result=`scalaenv version-name`
    if [ "$result" ] ; then
      echo "$result"
    else
      echo "scala"
    fi
  else
    echo ""
  fi
}
# }}}2
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# goenv-prompt: "{{{2
function goenv_prompt {
  if type goenv > /dev/null 2>&1; then
    result=`goenv version`
    if [ "$result" ] ; then
      echo "$result"
    else
      echo "goenv"
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
  #if [ -n "$(pyenv_prompt)" ]; then
  #  bar_left_python="[%{%F{blue}%}$(pyenv_prompt)%{%f%}]"
  #fi
  #if [ -n "$(ndenv_prompt)" ]; then
  #  bar_left_node="[%{%F{green}%}$(ndenv_prompt)%{%f%}]"
  #fi
  #if [ -n "$(goenv_prompt)" ]; then
  #  bar_left_go="[%{%F{yellow}%}$(goenv_prompt)%{%f%}]"
  #fi
  #if [ -n "$(scalaenv_prompt)" ]; then
  #  bar_left_scala="[%{%F{magenta}%}$(scalaenv_prompt)%{%f%}]"
  #fi

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

  #local bar_left_length=$(count_prompt_characters "$bar_left")
  #local bar_rest_length=$[COLUMNS - bar_left_length]
  local bar_right_without_path="${prompt_bar_right:s/%d//}"
  local bar_right_without_path_length=$(count_prompt_characters "$bar_right_without_path")
  #local max_path_length=$[bar_rest_length - bar_right_without_path_length]
  #bar_right=${prompt_bar_right:s/%d/%(C,%${max_path_length}<...<%d%<<,)/}
  bar_right=${prompt_bar_right:s/%d/%(C,%<...<%d%<<,)/}
  #local separator="${(l:${bar_rest_length}::-:)}"

  #bar_right="%${bar_rest_length}<<${separator}${bar_right}%<<"
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

alias rr='command rm -rf'

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

# app_alias gv c cpp h rb php html haml mkd md txt
# app_alias gv js ru py pl hs lhs sql conf

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
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# "}}}1
#===============================================================================

src $HOME/.zshrc.local

# vim: ft=zsh fdm=marker et sw=2 sts=2 ts=2
