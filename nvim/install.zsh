#!/bin/zsh

if ! type nvim > /dev/null 2>&1; then
  echo 'installing neovim...'
  if type brew > /dev/null 2>&1; then
    brew install neovim
  else
    echo 'unknown install operation' >&2
  fi
fi

cd $(dirname $0)
__dirname=$(pwd)
echo $__dirname

mkdir -p $HOME/.config
rm -rf $HOME/.config/nvim
ln -s $__dirname/.config/nvim $HOME/.config/nvim
