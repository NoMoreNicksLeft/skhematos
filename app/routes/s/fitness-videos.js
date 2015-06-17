module.exports = function(express, app){

    var router = express.Router();

    router.get('/', function(req, res, next) {
        res.send('fitness videos, we fucking did it!');
    });

    return router;
}