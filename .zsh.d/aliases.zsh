#===============================================================================
# Note: "{{{1
# alias.zsh
#
# Author: iyuuya <i.yuuya@gmail.com>
# }}}1
#===============================================================================

if type /Applications/MacVim.app/Contents/MacOS/Vim > /dev/null 2>&1; then
  alias vim='env LANG=ja_JP.UTF-8 reattach-to-user-namespace /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
fi

if type mvim > /dev/null 2>&1; then
  alias gvim='reattach-to-user-namespace mvim'
fi

alias v='vim'
alias gv='gvim'

if type /usr/local/Cellar/emacs/24.3/Emacs.app/Contents/MacOS/Emacs > /dev/null 2>&1; then
  alias emacs="/usr/local/Cellar/emacs/24.3/Emacs.app/Contents/MacOS/Emacs -nw"
fi
alias em=emacs

# git: "{{{2
if type hub > /dev/null 2>&1; then
  alias git='hub'
fi

alias g='git'

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
alias gsb='g submodule'
alias gsu="g submodule foreach 'git checkout master; git pull'"
alias grmal='git ls-files -z --deleted | xargs -0 git rm'

# "}}}2

# ruby: "{{{2

# bundle:
alias b='bundle'
alias bi='b install'
alias be='b exec'

# rvm:
alias rvg='rvm gemset'
alias rvgl='rvm gemset list'
alias rvgc='rvm gemset create'

# rbenv:
alias rb='rbenv'
alias rbv='rbenv version'
alias rbvs='rbenv versions'
alias rbg='rbenv global'
alias rbl='rbenv local'
alias rbr='rbenv rehash'

# rake:
alias rk='rake'
alias rkt='rake -T'

# rails:
alias r='rails'
alias pw='powder'
alias pwr='pw restart'

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

app_alias gv c cpp h rb php html haml mkd md txt
app_alias js ru py pl hs lhs sql conf

if type /Applications/Tower.app/Contents/MacOS/Tower > /dev/null 2>&1; then
  alias tower="open /Applications/Tower.app"
fi

# }}}1

if type /Applications/Gyazo.app/Contents/MacOS/Gyazo> /dev/null 2>&1; then
  alias gyazo='/Applications/Gyazo.app/Contents/MacOS/Gyazo "$@"'
fi

if type tmux > /dev/null 2>&1; then
  alias t='tmux'
  alias tls='tmux ls'
  alias tks='tmux kill-session -t'
fi

# vim: et sw=2 sts=2 ts=2
# vim: ft=zsh fdm=marker
