FROM alpine:latest

MAINTAINER Kevin Edwards "<kedwards@kevinedwards.ca>"

RUN apk -v --no-cache --update add \
    bash \
    curl && \
    rm -rf /var/cache/apk/*

COPY test.sh .

RUN chmod +x test.sh

CMD ["/bin/sh", "test.sh"]

