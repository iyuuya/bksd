FROM amazonlinux
LABEL maintainer="iyuuya <i.iyuuya@gmail.com>"

RUN rm -rf /usr/local && \
    yum -y update && \
    yum groups install -y "Development tools" && \
    yum -y install ncurses-devel && \
    tmpdir="$(mktemp -d)" && \
    cd $tmpdir && \
    git clone --depth=1 --single-branch https://github.com/jonas/tig.git && \
    cd tig && \
    make configure && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    cd / && rm -rf $tmpdir && \
    yum -y groups remove "Development tools" && \
    yum -y remove ncurses-devel && \
    yum clean all && \
    rm -rf /var/cache/yum

CMD ["/usr/local/bin/tig"]
