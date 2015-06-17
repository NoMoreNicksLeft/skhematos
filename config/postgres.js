var config    = require('./config');
var pg        = require('pg');
var dbSetup   = require('pg-native');
var fs        = require('fs');
var path      = require('path');

console.log('Initializing asynchronous Postgres driver...');

pg.connect(config.conString, function(err, client, done) {
  if(err) {
    return console.error('Error: Unable to fetch pg client from pool.', err);
  }
  client.query('SELECT $1::int AS number', ['1'], function(err, result) {
    //call `done()` to release the client back to the pool
    done();

    if(err) {
      return console.error('Error: initial query failed.', err);
    }
    //console.log(result.rows[0].number);
    //output: 1
    client.end();
  });
});

// Let's go ahead and load our ddl files.
var client = new dbSetup();
client.connectSync(config.conString);
// Without this, we get spammed up with a bunch of notices like the following:
// NOTICE:  relation "x" already exists, skipping
client.querySync('SET client_min_messages TO WARNING');

var importing = function(importDir) {
  fs.readdirSync(importDir)
    .filter(function(file) {
      if (fs.statSync(path.join(importDir, file)).isDirectory()) {
        console.log('  ' + file);
        importing(path.join(importDir, file));
      }
      // Only load sql files. Duh.
      else if (path.extname(file) == ".sql") {
        return (file.indexOf('.') !== 0);
      }
    })
    // run ddl scripts
    .forEach(function(file) {
      console.log('    ' + file);
      var sqlFile = fs.readFileSync(path.join(importDir, file), "utf8");
      if (!config.dbClean) {
        sqlFile = sqlFile.replace('drop schema', '--drop schema');
        //console.log('this ' + sqlFile);
      }
      // Read the docs on this five times, still not sure how to catch errors.
      try {
        var result = client.querySync(sqlFile);
      }
      catch(err) {
        console.error('Error: ' + err);
      }
    });
}
console.log('Initializing database schemas...');
importing(config.ddlDir);
client.end();

console.log('Initializing Postgres connection pool...');
// Exported, woohoo!
module.exports = {
   query: function(text, values, cb) {
      pg.connect(function(err, client, done) {
        client.query(text, values, function(err, result) {
          done();
          cb(err, result);
        })
      });
   }
}