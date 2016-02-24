FROM debian:jessie

MAINTAINER David Villasmil "david.villasmil@gmail.com"


ENV DEBIAN_FRONTEND noninteractive
### RUN apt-get update && apt-get -y -q install sip-tester vim ngrep tcpdump ssldump && rm -rf /var/lib/apt/lists/*
RUN apt-get update \
    && apt-get -y -q install sip-tester git-core ngrep tcpdump \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/sipp
WORKDIR /root/sipp

RUN git clone https://davidcsi:M3ll4m0d4v1d@github.com/libon/voice-ci-tests.git

################################################
# Build:
### docker build -t davidcsi/sipp-github .

# Run in interactive mode and attach to existing network:
### docker run -i -t -v $PWD/root/sipp/ --name=sipp --net=http_network davidcsi/sipp /bin/bash
ENV DEBIAN_FRONTEND dialog

