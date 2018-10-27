FROM amazonlinux
LABEL maintainer="iyuuya <i.iyuuya@gmail.com>"

RUN rm -rf /usr/local && \
    yum -y update && \
    yum groups install -y "Development tools"
