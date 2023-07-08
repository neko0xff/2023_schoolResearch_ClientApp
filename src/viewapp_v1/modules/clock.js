const moment = require('moment');
var ConfigParser = require('configparser');
const configZone = new ConfigParser();

/*時區設定*/
configZone.read('./modules/config/clockSet.cfg');
configZone.sections();
var locaLang=configZone.get('timezone','locaLang');
var localZone=configZone.get('timezone','localZone');;

/*outpuut console Time*/
function consoleTime(){
    var clock = new Date();
    var nowTime = clock.toLocaleString(locaLang, {timeZone: localZone}); //時區
    return nowTime;
}

/*SQL date&time*/
function SQLDate(){
    var clock = new moment();
    var dateFormat=configZone.get('formatStyle','dateFormat');
    var Date=clock.format(dateFormat);
    return Date;
};
function SQLTime(){
    var clock = new moment();
    var timeFormat=configZone.get('formatStyle','timeFormat');
    var Time=clock.format(timeFormat);
    return Time;
}

module.exports={
    consoleTime:consoleTime,
    SQLDate:SQLDate,
    SQLTime:SQLTime
};