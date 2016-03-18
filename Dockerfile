FROM debian:jessie

MAINTAINER David Villasmil "david.villasmil@gmail.com"


ENV DEBIAN_FRONTEND noninteractive
### RUN apt-get update && apt-get -y -q install sip-tester vim ngrep tcpdump ssldump && rm -rf /var/lib/apt/lists/*
RUN apt-get update \
    && apt-get -y -q install sip-tester git-core ngrep tcpdump libdata-uuid-perl libuuid-perl libfcgi-perl libnet-address-ip-local-perl libtimedate-perl libdbi-perl libssl-dev libpcap-dev ncurses-dev build-essential wget nano\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# let's do the sipp stuff
RUN mkdir -p /root/
WORKDIR /root/
RUN wget http://vorboss.dl.sourceforge.net/project/sipp/sipp/3.4/sipp-3.3.990.tar.gz
RUN tar -xvzf sipp-3.3.990.tar.gz
RUN cd sipp-3.3.990
WORKDIR /root/sipp-3.3.990
RUN ./configure --with-openssl --with-pcap && make && make install

COPY conf/id_rsa.github /root/.ssh/id_rsa.github
COPY conf/ssh_config /root/.ssh/config

WORKDIR /root/
RUN cd /root/
RUN git clone git@github.com:libon/voice-ci-tests.git

RUN cd /root/voice-ci-tests
WORKDIR /root/voice-ci-tests
RUN ./launch_tests.pl qap.cfg
################################################
# Build:
### docker build -t davidcsi/sipp-github .

# Run in interactive mode and attach to existing network:
### docker run -i -t -v $PWD/root/sipp/ --name=sipp --net=http_network davidcsi/sipp /bin/bash
ENV DEBIAN_FRONTEND dialog
