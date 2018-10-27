FROM iyuuya/builder:latest
LABEL maintainer="iyuuya <i.iyuuya@gmail.com>"

RUN yum -y install ncurses-devel

RUN tmpdir="$(mktemp -d)" && \
    cd $tmpdir && \
    git clone --depth=1 --single-branch https://github.com/jonas/tig.git && \
    cd tig && \
    make configure && \
    ./configure --prefix=/usr/local && \
    make && \
    make install

CMD ["/usr/local/bin/tig"]
