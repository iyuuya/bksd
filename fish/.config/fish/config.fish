#===============================================================================
# Note:
# config.fish
#
# Author: iyuuya <i.yuuya@gmail.com>
#===============================================================================

# TERM
set -x TERM xterm-256color

# LANG/LC
set -x LANG ja_JP.UTF-8
set -U LC_TIME C

# PAGER
if type -q lv
  set -U PAGER lv
else
  set -U PAGER less
end

# EDITOR
if type -q nvim
  set -U EDITOR nvim
else if type -q vim
  set -U EDITOR vim
else
  set -U EDITOR vi
end

# paths
source ~/.config/fish/paths.fish

fish_vi_key_bindings

# vim: ft=fish
