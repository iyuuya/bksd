export LANG=C
export SECOND_LANG=ja_JP.UTF-8
export LC_TIME=C

function switch_locale() {
  if [ -n "$SECOND_LANG" ]; then
    tmp_lang=$LANG
    export LANG=$SECOND_LANG
    export SECOND_LANG=$tm_lang
    locale
  fi
}
