/*MQTT Broker lib*/
const aedes = require('aedes')();
const broker = require('net').createServer(aedes.handle);
var ConfigParser = require('configparser');
const configSet = new ConfigParser();
configSet.read('./modules/config/serviceSet.cfg');
configSet.sections();
var port = configSet.get('Service','MQTT');

/*時間*/
var clock=require('../clock.js');

/*主程式*/
broker.listen(port, function () {
    console.log(`[${clock.consoleTime()}] MQTT Server Started!`);
    console.log(`[${clock.consoleTime()}] MQTT Server URL: http://[Server_IP]:${port}`);
});

