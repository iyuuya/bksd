FROM amazonlinux
LABEL maintainer="iyuuya <i.iyuuya@gmail.com>"

ARG GIT_TAG=master

RUN rm -rf /usr/local && \
    yum -y update && \
    yum groups install -y "Development tools" && \
    yum install -y cmake python3-{devel,pip} && \
    pip-3 install neovim --upgrade && \
    tmpdir="$(mktemp -d)" && \
    cd $tmpdir && \
    git clone --depth=1 --branch ${GIT_TAG} --single-branch https://github.com/neovim/neovim.git && \
    cd neovim && \
    make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/opt/nvim" && \
    make install && \
    cd / && \
    rm -rf $tmpdir && \
    yum -y groups remove "Development tools" && \
    yum -y remove cmake python3-{devel,pip} && \
    yum clean all && \
    rm -rf /var/cache/yum

CMD ["/opt/nvim/bin/nvim"]
