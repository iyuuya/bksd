if [ -x "`which fzf`" ] && [ -x "`ag`" ]; then
  export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
fi
