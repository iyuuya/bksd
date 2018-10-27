FROM iyuuya/builder:latest
LABEL maintainer="iyuuya <i.iyuuya@gmail.com>"

# TODO: split ag
RUN yum -y update && \
    yum -y install pcre-devel xz-devel

RUN tmpdir="$(mktemp -d)" && \
    cd $tmpdir && \
    git clone --depth=1 --single-branch https://github.com/ggreer/the_silver_searcher.git && \
    cd the_silver_searcher && \
    ./autogen.sh && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    cd / && \
    rm -rf $tmpdir

CMD ["/usr/local/bin/ag"]
