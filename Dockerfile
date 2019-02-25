FROM alpine:latest

MAINTAINER Kevin Edwards "<kedwards@kevinedwards.ca>"

RUN apk -v --no-cache --update add \
    openssh \
    git  \
    openjdk8 && \
    rm -rf /var/cache/apk/*

COPY build/libs/calculator-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]


ENTRYPOINT ["java", "-jar", "app.jar"]
