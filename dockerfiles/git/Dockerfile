# TODO git/contrib/subtree
# TODO git/contrib/workdir
# TODO git/contrib/diff-highlight
FROM amazonlinux
LABEL maintainer="iyuuya <i.iyuuya@gmail.com>"

RUN rm -rf /usr/local && \
    yum -y update && \
    yum groups install -y "Development tools" && \
    yum -y install curl-devel expat-devel gettext-devel openssl-devel perl-devel \
    zlib-devel perl-ExtUtils-MakeMaker asciidoc xmlto docbook2X && \
    tmpdir="$(mktemp -d)" && \
    cd $tmpdir && \
    git clone --depth=1 --single-branch https://github.com/git/git.git && \
    cd git && \
    make configure && \
    ./configure --prefix=/usr/local && \
    make all && \
    make install && \
    cd / && \
    rm -rf $tmpdir && \
    yum -y groups remove "Development tools" && \
    yum -y remove curl-devel expat-devel gettext-devel openssl-devel perl-devel \
    zlib-devel perl-ExtUtils-MakeMaker asciidoc xmlto docbook2X && \
    yum clean all && \
    rm -rf /var/cache/yum

CMD ["/usr/local/bin/git"]

# vim: ft=dockerfile
