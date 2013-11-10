[[ $UID > 0 && $UID = $GID ]] && umask 002 || umask 022

export LSCOLORS=exfxcxdxbxegedabagacad

PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

source ~/.zsh.d/locale.zsh
source ~/.zsh.d/pager.zsh
source ~/.zsh.d/vi-mode.zsh
source ~/.zsh.d/rvm.zsh
