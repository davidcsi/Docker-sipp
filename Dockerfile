FROM debian:jessie

MAINTAINER David Villasmil "david.villasmil@gmail.com"


ENV DEBIAN_FRONTEND noninteractive
### RUN apt-get update && apt-get -y -q install sip-tester vim ngrep tcpdump ssldump && rm -rf /var/lib/apt/lists/*
RUN apt-get update \
    && apt-get -y -q install sip-tester git-core ngrep tcpdump libuuid-perl libfcgi-perl libnet-address-ip-local-perl libtimedate-perl libdbi-perl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/sipp
WORKDIR /root/sipp

COPY conf/id_rsa.github /root/.ssh/id_rsa.github
COPY conf/ssh_config /root/.ssh/config

RUN git clone git@github.com:libon/voice-ci-tests.git
RUN cd /root/sipp/voice-ci-tests
WORKDIR /root/sipp/voice-ci-tests
RUN ./launch_tests.pl qap.cfg
################################################
# Build:
### docker build -t davidcsi/sipp-github .

# Run in interactive mode and attach to existing network:
### docker run -i -t -v $PWD/root/sipp/ --name=sipp --net=http_network davidcsi/sipp /bin/bash
ENV DEBIAN_FRONTEND dialog
