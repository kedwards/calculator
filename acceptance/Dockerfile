FROM alpine:latest

MAINTAINER Kevin Edwards "<kedwards@kevinedwards.ca>"

RUN apk -v --no-cache --update add \
    curl
    rm -rf /var/cache/apk/*

COPY build/libs/calculator-0.0.1-SNAPSHOT.jar app.jar

COPY ./acceptance/test.sh test.sh

RUN chmod +x test.sh

CMD ["bash", "test.sh"]

