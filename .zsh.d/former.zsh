#===============================================================================
# Note: "{{{1
# former.zsh
#
# Author: iyuuya <i.yuuya@gmail.com>
# }}}1
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
  # rbenv : [1.9.3]
  if [ -n "$(rbenv_prompt)" ]; then
    bar_left_ruby="[%{%F{red}%}$(rbenv_prompt)%{%f%}]"
  fi
  if [ -n "$(pyenv_prompt)" ]; then
    bar_left_python="[%{%F{green}%}$(pyenv_prompt)%{%f%}]"
  fi

  local bar_left="${bar_left_self}${bar_left_date}${bar_left_ruby}${bar_left_python}>>-"
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

# vim: ft=zsh fdm=marker
