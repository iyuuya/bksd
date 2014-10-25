#===============================================================================
# Note: "{{{1
# locales.zsh
#
# Author: iyuuya <i.yuuya@gmail.com>
# }}}1
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

# vim: foldmethod=marker foldlevel=0
