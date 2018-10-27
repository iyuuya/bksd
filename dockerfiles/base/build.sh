#!/bin/sh

REPO=iyuuya/bksd
tag=base

docker build -t "${REPO}:${tag}" .
