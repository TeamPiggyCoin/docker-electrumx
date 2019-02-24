#BUILDS teampiggycoin/electrumx

FROM qlustor/alpine-runit:3.8
MAINTAINER Team PiggyCoin <team@piggy-coin.com>

ENV TCP_PORT=50001
ENV SSL_PORT=50002
ENV APP_DIR /electrumx
ENV APP_USER electrumx
ENV DATA_DIR /home/electrumx
ENV DB_DIRECTORY $DATA_DIR/leveldb
ENV SSL_CERTFILE $DATA_DIR/electrumx.crt
ENV SSL_KEYFILE $DATA_DIR/electrumx.key
ENV ALLOW_ROOT 1
ENV HOST ""

ADD . /

# Install Python 3.x
RUN chmod +x /etc/service/electrumx/run \
 && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk-install --update python3 python3-dev leveldb-dev build-base git \
 && pip3 install --upgrade --no-cache-dir pip setuptools aiohttp pylru plyvel x11_hash \
 && git clone https://github.com/TeamPiggyCoin/electrumx.git /$APP_DIR \
 && cd /$APP_DIR \
 && python3 setup.py install \
 && adduser -D -g "" $APP_USER \
 && apk del build-base git
 
WORKDIR $DATA_DIR
VOLUME $DATA_DIR
EXPOSE 50001 50002

ENTRYPOINT ["/sbin/runit-docker"]
