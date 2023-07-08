var express = require('express');
var swaggerUi = require('swagger-ui-express');
const swaggerDocument = require('./config/swagger.json');
const compression = require('compression');
var clock=require('./clock.js');
var ConfigParser = require('configparser');
const configSet = new ConfigParser();
configSet.read('./modules/config/serviceSet.cfg');
configSet.sections();

/*Server 起始設定*/
var httpService=express();
var port=configSet.get('Service','HTTP'); 

/*啟用時使用的設定*/
httpService.use(compression()); //啟用gzip壓縮
httpService.use(express.urlencoded({ extended: false })); //傳送方式：x-www-form-urlencoded
httpService.use(express.json()); //傳送方式：json
httpService.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument)); //API Docs

/*通訊埠*/
httpService.listen(port,function(){
  console.log(`[${clock.consoleTime()}] HTTP API Server Started!`);
  console.log(`[${clock.consoleTime()}] HTTP API Server URL: http://[Server_IP]:%s`,port);
});

function app(){
    return httpService;
}

module.exports={
    app:app,
};