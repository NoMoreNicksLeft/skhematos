var path = require('path'),
rootPath = path.normalize(__dirname + '/../..');

module.exports = {
    root: rootPath,
    port: process.env.PORT || 3000,
    ddlDir : rootPath + '/app/ddl',
    conString: "postgres://joyler:@localhost:5432/joyler" 
}