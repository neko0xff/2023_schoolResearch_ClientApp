var mqttClient=require('../modules/mqtt/mqttClient.js');

/*訂閱測試*/
mqttClient.Sub("/Sensor01/hum");
mqttClient.Sub("/Sensor01/temp");
mqttClient.Sub("/Sensor01/tvoc");
mqttClient.Sub("/Sensor01/co2");
mqttClient.Sub("/Sensor01/co");
mqttClient.Sub("/Sensor01/pm25");
mqttClient.Sub("/Sensor01/o3");