[![](https://images.microbadger.com/badges/image/teampiggycoin/electrumx.svg)](https://microbadger.com/images/teampiggycoin/electrumx "Get your own image badge on microbadger.com")

This is a trusted build on the [DockerHub repository](https://hub.docker.com/r/teampiggycoin/electrumx/).

To run:

docker run -d -v /home/electrumx:/home/electrumx -p 54485:50001 --link piggycoind:piggycoind --name piggyelectrumx teampiggycoin/electrumx

Notes:

This connects by default to the dockerized teampiggycoin/piggycoind container if running on the same host (host-named piggycoind). Do not forget to add the assigned docker IP address of this container to the newpiggycoin.conf of the piggycoind container to allow RPC.
