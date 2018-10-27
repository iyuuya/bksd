# docker build -t iyuuya/bksd:base --no-cache .

FROM iyuuya/git:latest as git
FROM iyuuya/tig:latest as tig
FROM iyuuya/nvim:0.3.1-squash as neovim
FROM iyuuya/tmux:2.8-squash as tmux
FROM iyuuya/gotoolpack as gotoolpack
FROM iyuuya/ag:latest as ag

FROM amazonlinux
LABEL maintainer="iyuuya <i.iyuuya@gmail.com>"

RUN yum -y update && \
    yum -y install \
    zsh \
    util-linux-user \
    tree \
    jq \
    libevent && \
    yum clean all && \
    rm -rf /var/cache/yum
RUN chsh -s /bin/zsh

# ==========================

COPY --from=git /usr/local/ /usr/local/
COPY --from=tig /usr/local/ /usr/local/
COPY --from=neovim /opt/nvim /usr/local/
COPY --from=tmux /opt/tmux /usr/local/
COPY --from=gotoolpack /gotools/* /usr/local/bin/
COPY --from=ag /usr/local/ /usr/local/

# ==========================

# TODO: highway
# TODO: ripgrep

# vim: ft=dockerfile
