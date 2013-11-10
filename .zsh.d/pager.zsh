if type lv > /dev/null 2>&1; then
  export PAGER="lv"
else
  export PAGER="less"
fi

if [ "$PAGER" = "lv" ]; then
  export LV="-c -l"
fi

alias lv="$PAGER"
alias less="$PAGER"
