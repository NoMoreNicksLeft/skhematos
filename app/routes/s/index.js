    module.exports = function(express, app){

        var router = express.Router();
        var fs = require('fs');

        /* The root of s is just a list of available schemas and links to documentation. */
        router.get('/', function(req, res, next) {
            res.send('we are in s!');
            //res.render('index', { title: 'Express' });
        });

        /**/
        router.get(/^\/(\w+)(?:\/)?.*?$/, function(req, res, next){
            var schema_module;
            var schema_name = req.params[0];
            try {
                schema_module = require('./' + schema_name)(express, app);
                if (app.disabled(schema_name)) { router.use('/' + schema_name, schema_module); }
                app.enable(schema_name);
                next();
            }
            catch(e) {
                console.warn('DEBUG: No such schema/module, ' + schema_name);
            }
        });

        return router;
    }