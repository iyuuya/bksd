#===============================================================================
# Note: "{{{1
# .zshenv
#
# Author: iyuuya <i.yuuya@gmail.com>
# }}}1
#===============================================================================

#===============================================================================
# Initialize: "{{{1

# mask
[[ $UID > 0 && $UID == $GID ]] && umask 002 || umask 022

# ls color (BSD)
export LSCOLORS=exfxcxdxbxegedabagacad
# default color theme for vim (iTerm)

function solarized {
  export VIM_COLORSCHEME=solarized
  export VIM_BACKGROUND=dark
}

case ${OSTYPE} in
  linux*)
    export TERM=xterm-256color
    ;;
esac

# "}}}1
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
# Locale: "{{{1

case ${OSTYPE} in
  darwin*)
    export LANG=ja_JP.UTF-8
    export SECOND_LANG=C
    ;;
  linux*)
    export LANG=C
    export SECOND_LANG=ja_JP.UTF-8
    ;;
  *)
    export LANG=C
    ;;
esac

export LC_TIME=C

# Switch locale
function swlc() {
  if [ -n "$SECOND_LANG" ]; then
    tmp_lang=$LANG
    export LANG=$SECOND_LANG
    export SECOND_LANG=$tmp_lang
    locale
  fi
}

# "}}}1
#===============================================================================

#===============================================================================
# Path: "{{{1

# PATH

# Does not register a duplicate PATH.
# typeset -U path
# 
# path=(
#   # ~/bin
#   $HOME/bin(N-/)
#   # Homebrew
#   $HOME/brew/bin(N-/)
#   # cabal
#   $HOME/.cabal/bin(N-/)
#   # System
#   {/usr/local,/usr/local/share/npm,/usr,}/bin(N-/)
#   # Mac
#   /usr/X11/bin(N-/)
# )
# 
# # SUDO_PATH
# typeset -xT SUDO_PATH sudo_path
# typeset -U sudo_path
# sudo_path=({,/usr/local,/usr}/sbin(N-/))

# PATH=$PATH:$SUDO_PATH

export PATH=$HOME/bin:/usr/local/bin:/usr/local/share/npm/bin:/usr/bin:/usr/X11/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:

# man path
typeset -U manpath
manpath=({/usr/local,/usr}/share/man(N-/))

# pkg-config path
pkg_config_path=({/usr/local,/usr}/lib/pkgconfig(N-/))

# other path
case ${OSTYPE} in
  darwin*)
    export NODE_PATH=/usr/local/lib/node
    export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
    ;;
esac

# "}}}1
#===============================================================================

#===============================================================================
# Pager: "{{{1

if type lv > /dev/null 2>&1; then
  export PAGER="lv"
else
  export PAGER="less"
fi

# lv: "{{{2

if [ "$PAGER" = "lv" ]; then
  export LV="-c -l"
fi

alias lv="$PAGER"
alias less="$PAGER"

# "}}}2

# "}}}1
#===============================================================================

#===============================================================================
# Grep: "{{{1

# if type ggrep > /dev/null 2>&1; then
#   alias grep=ggrep
# fi
# 
# grep_version="$(grep --version | head -n 1 | sed -e 's/^[^0-9.]*\([0-9.]*\)$/\1/')"
# 
# export GREP_OPTIONS
# GREP_OPTIONS="--binary-files=without-match"
# case "$grep_version" in
#   1.*|2.[0-4].*|2.5.[0-3])
#     ;;
#   *)
#     # grep >= 2.5.4
#     # ディレクトリを再帰的にgrep
#     GREP_OPTIONS="--directories=recurse $GREP_OPTIONS"
#     ;;
# esac
# 
# # color
# if grep --help | grep -q -- --color; then
#   GREP_OPTIONS="--color=auto $GREP_OPTIONS"
# fi

# "}}}1
#===============================================================================

#===============================================================================
# sed: "{{{1

if type gsed > /dev/null 2>&1; then
  alias sed=gsed
fi

# "}}}1
#===============================================================================

#===============================================================================
# editor: "{{{1

export EDITOR=vim

if ! type vim > /dev/null 2>&1; then
  alias vim=vi
fi

# "}}}1
#===============================================================================

#===============================================================================
# Shell: "{{{1

case ${OSTYPE} in
  darwin*)
    export SHELL=/usr/local/bin/zsh
    ;;
  *)
    export SHELL=/bin/zsh
    ;;
esac

# "}}}1
#===============================================================================

#===============================================================================
# Other initialize: "{{{1

case ${OSTYPE} in
  linux*)
    export LIBGL_ALWAYS_INDIRECT=1
    export COLOR_THEME=solarized
    ;;
esac


if type rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"
  src $HOME/brew/Cellar/rbenv/0.4.0/completions/rbenv.zsh
fi

src $HOME/.nvm/nvm.sh

# "}}}1
#===============================================================================

src $HOME/.zshenv.local

# vim: ft=zsh fdm=marker

#===============================================================================
# Note: "{{{1
# .zshrc
#
# Author: iyuuya <i.yuuya@gmail.com>
# }}}1
#===============================================================================

#===============================================================================
# Load: "{{{1
src ~/.zsh.d/config/packages.zsh
# "}}}1
#===============================================================================

#===============================================================================
# Changing Directories: "{{{1

setopt auto_cd
setopt auto_pushd
setopt chase_links
setopt pushd_ignore_dups
setopt pushd_to_home

cdpath=($HOME)
chpwd_functions=($chpwd_functions dirs)

# "}}}1
#===============================================================================

#===============================================================================
# Completion: "{{{1

## Initialize

autoload -U compinit
compinit

case ${OSTYPE} in
  darwin*)
    fpath=($HOME/brew/share/zsh-completions $fpath)
    ;;
esac

## Grouping completion
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''

zstyle ':completion:*:default' menu select=2

zstyle ':completion:*:default' list-colors ""

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'

zstyle ':completion:*' completter \
  _oldlist _complete _match _history _ignored _approximate _prefix

zstyle ':completion:*' use-cache yes

zstyle ':completion:*' varbose yes

zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

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

setopt always_last_prompt
setopt auto_list
setopt auto_menu
setopt auto_param_keys
setopt auto_param_slash
setopt auto_remove_slash
setopt complete_aliases
setopt complete_in_word
setopt glob_complete
setopt hash_list_all
setopt list_ambiguous
unsetopt list_beep
setopt list_packed
setopt list_types
setopt menu_complete

# "}}}1
#===============================================================================

#===============================================================================
# Expansion and Globbing: "{{{1

setopt bad_pattern
setopt bare_glob_qual
setopt case_glob
setopt case_match
setopt csh_null_glob # null_glob
setopt equals
setopt extended_glob
setopt glob
setopt magic_equal_subst
setopt mark_dirs
setopt multibyte
setopt nomatch
setopt numeric_glob_sort
setopt rc_expand_param
setopt rematch_pcre
setopt unset

# "}}}1
#===============================================================================

#===============================================================================
# History: "{{{1

HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=$HISTSIZE

setopt append_history
setopt extended_history
setopt no_hist_beep
setopt hist_expand # bang_hist
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_by_copy
setopt hist_verify
setopt inc_append_history
setopt share_history

autoload history-search-end

# "}}}1
#===============================================================================

#===============================================================================
# Initialisation: "{{{1

setopt global_export
setopt global_rcs
setopt rcs

# "}}}1
#===============================================================================

#===============================================================================
# Input/Output: "{{{1

setopt aliases
setopt clobber
setopt no_flow_control
setopt ignore_eof
setopt hash_cmds
setopt hash_dirs
setopt path_dirs
setopt short_loops

# "}}}1
#===============================================================================

#===============================================================================
# Job Control: "{{{1

setopt bg_nice
setopt check_jobs
setopt hup
setopt long_list_jobs
setopt notify

# "}}}1
#===============================================================================

#===============================================================================
# Prompting: "{{{1

setopt prompt_cr
setopt prompt_sp
setopt prompt_percent
setopt prompt_subst
setopt transient_rprompt

#-------------------------------------------------------------------------------
# rvm-prompt: "{{{2
function rvm_prompt {
  if type rvm > /dev/null 2>&1; then
    result=`rvm-prompt v g`
    if [ "$result" ] ; then
      echo "$result"
    else
      echo "rvm"
    fi
  else
    echo ""
  fi
}
# "}}}2
#-------------------------------------------------------------------------------

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
# git-prompt: "{{{2
# Show branch name in Zsh's prompt
# autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
# 
# function git_prompt {
#   local name st color gitdir action
#   if [[ "$PWD" =~ '/促.git(/.*)?$' ]]; then
#     return
#   fi
#   name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
#   if [[ -z $name ]]; then
#     return
#   fi
# 
#   gitdir=`git rev-parse --git-dir 2> /dev/null`
#   action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"
# 
#   st=`git status 2> /dev/null`
#   if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
#     color=%F{green}
#   elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
#     color=%F{yellow}
#   elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
#     color=%B%F{red}
#   else
#     color=%F{red}
#   fi
#   echo "$color$name$action%f%b"
# }
# "}}}2
#-------------------------------------------------------------------------------

## return prompt format expand characters count (not support Japanese)
function count_prompt_characters()
{
  print -n -P -- "$1" | sed -e $'s/\e\[[0-9;]*m//g' | wc -m | sed -e 's/ //g'
}

#-------------------------------------------------------------------------------
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u%b%f:"
zstyle ':vcs_info:*' actionformats '%b|%a'

function update_prompt() # "{{{2
{
  # user@host(2012/03/04 05:06)[1.9.3]>>-: "{{{3
  # user@host
  bar_left_self="%{%F{green}%}%n%{%F{yellow}%}@%{%F{red}%}%m%{%f%}"
  # date: (2012/03/04 05:06)
  bar_left_date="(%D{%Y/%m/%d %H:%M})"
  # rbenv or rvm: [1.9.3]
  if [ -n "$(rvm_prompt)" ]; then
    bar_left_ruby="[%{%F{cyan}%}$(rvm_prompt)%{%f%}]"
  elif [ -n "$(rbenv_prompt)" ]; then
    bar_left_ruby="[%{%F{cyan}%}$(rbenv_prompt)%{%f%}]"
  fi

  local bar_left="${bar_left_self}${bar_left_date}${bar_left_ruby}>>-"
  # "}}}3

  # ----<master:project>-<<: "{{{3
  prompt_bar_right='${vcs_info_msg_0_}'
  # LANG=C vcs_info >&/dev/null
  # if [ -n "$(git_prompt)" ]; then
  #   prompt_bar_right="$(git_prompt):"
  # fi
  # -<master:project>-<<
  prompt_bar_right="<${prompt_bar_right}%{%F{yellow}%}%c%{%f%}>-<<"

  local bar_left_length=$(count_prompt_characters "$bar_left")
  local bar_rest_length=$[COLUMNS - bar_left_length]
  local bar_right_without_path="${prompt_bar_right:s/%d//}"
  local bar_right_without_path_length=$(count_prompt_characters "$bar_right_without_path")
  local max_path_length=$[bar_rest_length - bar_right_without_path_length]
  bar_right=${prompt_bar_right:s/%d/%(C,%${max_path_length}<...<%d%<<,)/}
  local separator="${(l:${bar_rest_length}::-:)}"

  bar_right="%${bar_rest_length}<<${separator}${bar_right}%<<"
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

precmd_functions=($precmd_functions vcs_info update_prompt)

# "}}}1
#===============================================================================

#===============================================================================
# Scripts and Functions: "{{{1

setopt exec
setopt multios

# "}}}1
#===============================================================================

#===============================================================================
# Zle: "{{{1

setopt no_beep
setopt vi # bindkey -v

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
# Alias: "{{{1

# global: "{{{2

alias -g L='|& $PAGER'
alias -g G='| grep'
alias -g C='| cat -n'
alias -g H='| head'
alias -g T='| tail'
alias -g A='| awk'
alias -g S='| sed'
alias -g W='| wc'
alias -g D='> /dev/null 2>&1'

# "}}}2

# normal: "{{{2

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

# "}}}2

src "$HOME/.zsh.d/alias.zsh"

# "}}}1
#===============================================================================

#===============================================================================
# Function: "{{{1

# reload config files
function reload()
{
  src "$HOME/.zshenv"
  src "$HOME/.zshrc"
}

function search ()
{
  if [ $# = 0 ]
  then
    echo 'usage: search [path] text'
    return
  fi
  local d="."
  local w=$1
  if [ $# = 2 ]
  then
    d=$1
    w=$2
  fi
  find "$d" -print0 | xargs -0 grep -nE "$w"
}

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

# "}}}1
#===============================================================================

src "$HOME/.zshrc.local"

# vim: ft=zsh fdm=marker
