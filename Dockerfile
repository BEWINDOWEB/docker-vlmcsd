FROM alpine:3.12.0 as builder
WORKDIR /root
RUN apk add --no-cache make build-base wget && \
    wget https://github.com/Wind4/vlmcsd/archive/svn1113.tar.gz && \
    tar -zxvf svn1113.tar.gz && mv vlmcsd-svn1113 vlmcsd && \
    cd vlmcsd/ && \
    make

FROM alpine:3.12.0
MAINTAINER bewindoweb<bewindoweb1995@foxmail.com>
WORKDIR /root/
COPY --from=builder /root/vlmcsd/bin/vlmcsd /usr/bin/vlmcsd
EXPOSE 1688/tcp
CMD [ "/usr/bin/vlmcsd", "-D", "-d" ]
