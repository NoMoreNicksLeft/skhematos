module.exports = function(express, app){

    /* We'll set up the home page and other blog-style pages here. */
    app.get('/', function(req, res, next) {
      res.render('index', { title: 'Express' });
    });

    // router.get('/about')

    // Set up the schema tree
   var s = require('./s/index')(express, app);
   app.use('/s', s);

}