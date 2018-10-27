#!/bin/sh

REPO=iyuuya/tmux

build() {
  if [ $# = 0 ]; then
    tag=latest
    opt=
  elif [ $# = 1 ]; then
    tag="$1"
    opt=" --build-arg v$1"
  else
    exit 1
  fi
  docker build -t "${REPO}:${tag}" ${opt} .
}

build
build 2.8
