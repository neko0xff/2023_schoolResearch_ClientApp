const swaggerAutogen = require('swagger-autogen')();
const outputFile = './modules/config/swagger.json'; // 輸出的生成結果
const endpointsFiles = ['./rules/httpAPI.js']; //要轉換的API程式

/*swaggerAutogen 的方法*/
swaggerAutogen(outputFile, endpointsFiles); 