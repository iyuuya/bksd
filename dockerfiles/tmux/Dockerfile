FROM iyuuya/builder:latest
LABEL maintainer="iyuuya <i.iyuuya@gmail.com>"

ARG GIT_TAG=master

RUN yum install -y libevent-devel ncurses-devel
RUN tmpdir="$(mktemp -d)" && \
    cd $tmpdir && \
    git clone --depth=1 --branch ${GIT_TAG} https://github.com/tmux/tmux.git && \
    cd tmux && \
    sh autogen.sh && \
    ./configure --prefix=/opt/tmux && \
    make && \
    make install && \
    cd / && \
    rm -rf $tmpdir

CMD ["/opt/tmux/bin/tmux"]
