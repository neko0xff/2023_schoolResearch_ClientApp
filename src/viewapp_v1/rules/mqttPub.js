/*MQTT Lib*/
var mqttRouter= require("../modules/mqtt/mqttPubRouter.js");

/*定義的MQTT 路由*/
mqttRouter.pubSensor("Sensor01","hum");
mqttRouter.pubSensor("Sensor01","temp");
mqttRouter.pubSensor("Sensor01","tvoc");
mqttRouter.pubSensor("Sensor01","co2");
mqttRouter.pubSensor("Sensor01","co");
mqttRouter.pubSensor("Sensor01","pm25");
mqttRouter.pubSensor("Sensor01","o3");


