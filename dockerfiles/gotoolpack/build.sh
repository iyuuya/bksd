#!/bin/sh

REPO=iyuuya/gotoolpack
tag=latest

docker build -t "${REPO}:${tag}" .
