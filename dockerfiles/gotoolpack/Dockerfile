FROM golang
LABEL maintainer="iyuuya <i.yuuya@gmail.com>"

RUN mkdir /gotools

# ghq
RUN git clone --depth=1 --single-branch https://github.com/motemen/ghq.git && \
    cd ghq && \
    GOOS=linux GOARCH=amd64 make && \
    cp ghq /gotools/ghq

# fzf
RUN git clone --depth=1 --single-branch https://github.com/junegunn/fzf.git && \
    cd fzf && \
    GOOS=linux GOARCH=amd64 make && \
    cp target/fzf-linux_amd64 /gotools/fzf

# hub
RUN git clone --depth=1 --single-branch https://github.com/github/hub.git && \
    cd hub && \
    go get -u github.com/github/hub/commands && \
    go get -u github.com/github/hub/github && \
    go get -u github.com/github/hub/ui && \
    GOOS=linux GOARCH=amd64 make && \
    cp bin/hub /gotools/hub
