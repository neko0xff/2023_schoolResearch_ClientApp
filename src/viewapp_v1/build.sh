image="neko_0xff/iotgateway_server"
NetworkMode="host"
docker build . -t $image --network=$NetworkMode