FROM debian:buster-slim

RUN  apt-get update \
  && apt-get install -y wget curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

RUN curl https://github.com/badaix/snapcast/releases/latest | grep -oE "[0-9]\.[0-9]{1,3}\.[0-9]{1,3}" > version

RUN  wget https://github.com/badaix/snapcast/releases/download/v$(cat version)/snapserver_$(cat version)-1_$(dpkg --print-architecture | sed 's/arm/armhf/g').deb
RUN  dpkg -i snapserver_$(cat version)-1_$(dpkg --print-architecture | sed 's/arm/armhf/g').deb \
  ;  apt-get update \
  && apt-get -f install -y \
  && rm -rf /var/lib/apt/lists/*
CMD ["/bin/bash","-c","/usr/bin/snapserver"]