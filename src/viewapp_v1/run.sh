port1="3095:3095"
port2="3094:3094"
image="neko_0xff/iotgateway_server"
NetworkMode="host"
ContainerName="IoTGateway_Server"
docker run --network=$NetworkMode --name=$ContainerName  --restart=always -p $port1 -p $port2 -d $image 