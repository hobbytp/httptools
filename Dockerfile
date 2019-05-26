FROM alpine:latest
MAINTAINER Hobby

RUN apk add --no-cache \
        alpine-sdk \
        libtool \
        autoconf \
        automake \
        libev-dev \
        zlib-dev \
        c-ares-dev \
        openssl-dev \
        jemalloc-dev

RUN NGHTTP2_VERSION='1.38.0' \
    && git clone --depth 1 --single-branch --branch v${NGHTTP2_VERSION} https://github.com/nghttp2/nghttp2 \
    && cd nghttp2 \
    && autoreconf -i && automake && autoconf && ./configure \
    && make && make install-strip \
    && cd .. && rm -rf nghttp2

VOLUME /tmp

ENTRYPOINT ["h2load"]
