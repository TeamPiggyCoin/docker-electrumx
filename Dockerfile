#BUILDS teampiggycoin/electrumx

FROM qlustor/alpine-runit:3.8
MAINTAINER Team PiggyCoin <team@piggy-coin.com>

# Install Python 3.x
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk-install --update python3 python3-dev leveldb-dev build-base git \
 && pip3 install --upgrade --no-cache-dir pip setuptools aiohttp pylru plyvel x11_hash \
 && git clone https://github.com/TeamPiggyCoin/electrumx.git /electrumx \
 && cd /electrumx \
 && python3 setup.py install \
 && apk del build-base git \
 && adduser -D -g "" electrumx
ADD . /

EXPOSE 5001 5002 8000
VOLUME /home/electrumx
ENTRYPOINT ["/sbin/runit-docker"]
