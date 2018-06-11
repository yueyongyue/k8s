FROM alpine:3.7

ENV TIME_ZONE Asia/Shanghai
RUN apk add --update ca-certificates && apk add --no-cache tzdata \
    && echo "${TIME_ZONE}" > /etc/timezone \
    && ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
ADD bin/k8s_api /usr/local/bin
ADD config/config /etc

ENTRYPOINT ["/usr/local/bin/k8s_api"]

EXPOSE 8080