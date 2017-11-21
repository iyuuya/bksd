#===============================================================================
# Note:
# paths.fish
#
# Author: iyuuya <i.yuuya@gmail.com>
#===============================================================================

set -l paths

switch (uname)
  case Darwin
    set paths $HOME/bin
    set paths $paths /usr/local/bin
    set paths $paths /usr/local/share/git-core/contrib/diff-highlight
    set paths $paths /usr/bin
    set paths $paths /bin
    set paths $paths /usr/X11/bin

    # anyenv
    if test -d $HOME/.anyenv
      set paths $HOME/.anyenv/bin $paths

      for D in (ls $HOME/.anyenv/envs)
        set paths $HOME/.anyenv/envs/$D/bin $HOME/.anyenv/envs/$D/shims $paths
      end
    end
    set paths $paths /usr/local/sbin /usr/sbin /sbin
end

set -x PATH $paths

# vim: ft=fish
