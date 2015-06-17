module.exports = function(express, app){

    var postgres = require('../../../config/postgres.js');
    var accepts  = require('accepts');
    var router   = express.Router();

    /* The /s/common branch should be empty. It's not a schema by itself, just a misc. bin for everything that two or 
       more schemas need. */

    /* This page is for humans, lists the available versions and related documentation. */
    router.get('/api', function(req, res, next) {

    });

    /* This page is for humans, but we need to bounce to the correct route module. */
    router.get('/api/:version', function(req, res, next) {

    });

    return router;
}