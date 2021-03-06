/**
 * Module dependencies.
 */

var express      = require('express');
var fs           = require('fs');
var favicon      = require('serve-favicon');

var env          = process.env.NODE_ENV = process.env.NODE_ENV || 'development';

var path         = require('path');
var logger       = require('morgan');

var cookieParser = require('cookie-parser');
var bodyParser   = require('body-parser');

/**
 * Configuration files.
 */


/**
 * Database.
 */

var db = require('./config/postgres');

/**
 * Express.
 */

var app = express();

/**
 * Routers.
 */

var routes = require('./app/routes/index')(express, app);
app.route('/', routes);

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// uncomment after placing your favicon in /public
//app.use(favicon(__dirname + '/public/favicon.ico'));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));



// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});

module.exports = app;