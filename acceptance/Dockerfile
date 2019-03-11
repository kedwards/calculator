FROM debian:stretch-slim

LABEL maintainer="Kevin Edwards <kedwards@kevinedwards.ca>"

RUN apt-get install curl 

COPY test.sh .

RUN chmod +x test.sh

CMD ["/bin/bash", "test.sh"]
