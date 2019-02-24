#BUILDS teampiggycoin/electrumx

FROM qlustor/alpine-runit:3.8
MAINTAINER Team PiggyCoin <team@piggy-coin.com>

ENV DB_DIRECTORY /home/electrumx/leveldb
ENV ALLOW_ROOT 1

ADD . /

# Install Python 3.x
RUN chmod +x /etc/service/electrumx/run \
 && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk-install --update python3 python3-dev leveldb-dev build-base git \
 && pip3 install --upgrade --no-cache-dir pip setuptools aiohttp pylru plyvel x11_hash \
 && git clone https://github.com/TeamPiggyCoin/electrumx.git /electrumx \
 && cd /electrumx \
 && python3 setup.py install \
 && apk del build-base git
 
EXPOSE 50001 50002
VOLUME /home/electrumx
ENTRYPOINT ["/sbin/runit-docker"]
