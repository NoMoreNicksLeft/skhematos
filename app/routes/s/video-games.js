module.exports = function(express, app){

    var router = express.Router();

    router.get('/', function(req, res, next) {
        res.send('video games, we fucking did it!');
    });

    return router;
}