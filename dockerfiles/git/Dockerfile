# TODO git/contrib/subtree
# TODO git/contrib/workdir
# TODO git/contrib/diff-highlight
FROM iyuuya/builder:latest
LABEL maintainer="iyuuya <i.iyuuya@gmail.com>"

RUN yum -y update && \
    yum -y install curl-devel expat-devel gettext-devel openssl-devel perl-devel \
    zlib-devel perl-ExtUtils-MakeMaker asciidoc xmlto docbook2X

RUN tmpdir="$(mktemp -d)" && \
    cd $tmpdir && \
    git clone --depth=1 --single-branch https://github.com/git/git.git && \
    cd git && \
    make configure && \
    ./configure --prefix=/usr/local && \
    make all && \
    make install && \
    cd / && \
    rm -rf $tmpdir

CMD ["/usr/local/bin/git"]

# vim: ft=dockerfile
