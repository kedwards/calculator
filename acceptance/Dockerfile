FROM debian:stretch-slim

LABEL maintainer="Kevin Edwards <kedwards@kevinedwards.ca>"

RUN apt-get update && \
    apt-get install -yq curl

COPY test.sh .

RUN chmod +x test.sh

CMD ["/bin/bash", "test.sh"]
