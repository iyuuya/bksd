FROM amazonlinux
LABEL maintainer="iyuuya <i.iyuuya@gmail.com>"

ARG GIT_TAG=master

RUN rm -rf /usr/local && \
    yum -y update && \
    yum groups install -y "Development tools" && \
    yum install -y libevent-devel ncurses-devel && \
    tmpdir="$(mktemp -d)" && \
    cd $tmpdir && \
    git clone --depth=1 --branch ${GIT_TAG} https://github.com/tmux/tmux.git && \
    cd tmux && \
    sh autogen.sh && \
    ./configure --prefix=/opt/tmux && \
    make && \
    make install && \
    cd / && \
    rm -rf $tmpdir && \
    yum -y groups remove "Development tools" && \
    yum -y remove libevent-devel ncurses-devel && \
    yum clean all && \
    rm -rf /var/cache/yum

CMD ["/opt/tmux/bin/tmux"]
