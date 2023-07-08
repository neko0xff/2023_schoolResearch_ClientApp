/*相関函式庫*/
var mqttClient=require('./mqttClient.js');
var database=require('../database.js');
var clock=require('../clock.js');

/*Pub Client*/
async function pubRouter(Pubtopic,SQL){
    console.log("["+clock.consoleTime() + "] MQTT Pub= " + Pubtopic );
    var cnDB=database.cnDB();
    const connection = await cnDB.getConnection(); // 從連接池中獲取一個連接

    try{
        const [results, fields] = await connection.execute(SQL); // 執行 SQL 查詢
        var data=JSON.stringify(results);
        mqttClient.Pub(Pubtopic,data,5000);
        console.log(`[${clock.consoleTime()}] Pub Data= ${data}` );
    }catch(error){
        console.error("["+clock.consoleTime()`] Failed to execute query: ${error.message}`);
        mqttClient.Pub(Pubtopic,'Not Connect',5000);
        throw error;
    }finally{
        connection.release(); // 釋放連接
    }
}

async function pubSensor(device_ID,sensor){
    var readSQL = 'SELECT '+sensor+',date,time FROM ' + device_ID + '_Table ORDER BY `date` AND `time` DESC LIMIT 1;';
    var topicPub = "/"+device_ID+"/"+sensor;
    this.pubRouter(topicPub,readSQL);
}

module.exports={
    pubRouter:pubRouter,
    pubSensor:pubSensor,
}

