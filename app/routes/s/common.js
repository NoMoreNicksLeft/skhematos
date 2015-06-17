module.exports = function(express, app){

    var postgres = require('../../../config/postgres.js');
    var accepts  = require('accepts');
    var router   = express.Router();

    function valid_table(t) {
        // This is safe because though we're concentating strings for a sql statement, we're only allowing a specific, 
        // short list of sanitized values.
        switch (t) {
            case 'companies':
            case 'business_persons':
            case 'business_entities':
                return true;
                break;
            default:
                console.log('ERROR: Non-existent table selected (possible sql injection attempt), common.' + t);
                return false;
        }
    }

    /* We'll take care of the API here. */
    router.get('/api/:version/:table', function(req, res, next) {

        var version = req.params.version;
        var table   = req.params.table;
        var accept = accepts(req)

        var statement = 'select coalesce(array_to_json(array_agg(' +  table + "), true)::text, '[]')" + ' as data from common.' + table;
        var nullstatement = "select '[]' as data";

        // Determine the preferred content type.
        switch(accept.type('json')) {
            // case 'xml':
            //     res.setHeader('Content-Type', 'application/xml');
            //     statement = "select query_to_xml('select * from common." + table + "', true, false, '')::text as data";
            //     nullstatement = "select '<table xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n\n</table>' as data";
            //     break;
            case 'json':
                res.setHeader('Content-Type', 'application/json');
                break;
            default:
                res.setHeader('Content-Type', 'text/plain');
                break;
        }

        // We'll make sure this is a real table name.
        if (!valid_table(table)) { 
            statement = nullstatement;
        }

        // Let's do this.
        postgres.query(statement, [], function(err, result) {
            res.send(result.rows[0].data);
            console.log(table + ' ' + result.rows[0].data + ' ' + err);
        });
    });

    /**/
    router.post('/api/:version/:table', function(req, res, next) {
        
    });


    return router;
}