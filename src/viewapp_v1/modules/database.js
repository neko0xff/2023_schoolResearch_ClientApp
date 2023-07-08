/*資料庫連線設定*/
var ConfigParser = require('configparser');
const configDB = new ConfigParser();
var mysql = require('mysql2/promise');
configDB.read('./modules/config/cnSet.cfg');
configDB.sections();

var setDB=mysql.createPool({
    connectionLimit: configDB.get('MYSQL','connectionLimit'), // 設置最大連接數量
    host: configDB.get('MYSQL','DBsource') ,
    user: configDB.get('MYSQL','DBuser'),
    password: configDB.get('MYSQL','DBpassword') ,
    port: configDB.get('MYSQL','DBport'),
    database: configDB.get('MYSQL','cnDatabase')
});

function cnDB(){
    return setDB;
}

module.exports={
    cnDB:cnDB,
};