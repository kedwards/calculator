FROM debian:stretch-slim

LABEL maintainer="Kevin Edwards <kedwards@kevinedwards.ca>"

RUN apt-get update && apt-get --no-install-recommends install -yq curl

COPY test.sh .

RUN chmod +x test.sh

ENTRYPOINT ["/bin/bash", "test.sh"]