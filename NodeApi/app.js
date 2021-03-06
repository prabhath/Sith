
/**
 * Module dependencies.
 */

var express = require('express')
  , routes = require('./routes')
  , http = require('http')
  , path = require('path')
  , java = require('java')
  , eventRoutes = require('./routes/event')
  , analyticRoutes = require('./routes/analytics')
  , userMgmtRoutes = require('./routes/userMgmt')
  , passport = require("passport")
  , BearerStrategy =require('passport-http-bearer');
	
var app = express();
app.engine('html', require('hjs').renderFile);
app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'hjs');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));
});
/*
passport.use(new BearerStrategy(
    function(token, done) {
        User.findOne({ token: token }, function (err, user) {
            if (err) { return done(err); }
            if (!user) { return done(null, false); }
            return done(null, user, { scope: 'read' });
        });
    }
));
 */
app.all('/*', function(req, res, next) {
 res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "X-Requested-With");
  next();
});

app.configure('production', function(){
    console.log('prod');
    app.use(express.errorHandler());
});
app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
    console.log('dev');
});


process.on('uncaughtException', function(err) {
    // handle the error safely
    console.log(err);
});
//routes for web pages
app.get('/',routes.index);
app.get('/webDashboard',routes.getWebDashboard);
app.get('/myPerception',routes.percep_event);
app.get('/selfAnalyticDashboard',routes.getSelfAnalyticDashBoard);
app.get('/webDashboard2',routes.getWebDashBoard2);
app.get('/vote',routes.vote);
//routing for real time analytic data
app.get('/getPeriodicAvgPerception',analyticRoutes.sendPeriodicAvgPerception);
app.get('/countPeriodicPerceptions',analyticRoutes.sendPeriodicPerceptionCount);
//routing for perception count data
app.get('/countPerceptions',analyticRoutes.sendPerceptionCount); //this will count perception for each categories
app.get('/countPerceptions2',analyticRoutes.sendPerceptionCount2);
app.get('/countPerceptionsMapReduce',analyticRoutes.sendPerceptionCountMapReduce);
app.get('/getTimeAnalysis',analyticRoutes.getTimeAnalysis);
app.get('/getSelfAnalytics',analyticRoutes.getSelfAnalytics);
//routing for get all the perceptions available in the platform
app.get('/getMasterPerceptions',eventRoutes.getMasterPerceptions);
app.get('/getColorSchema',eventRoutes.getColorSchema);
//routing for event category
app.post('/addEvent',eventRoutes.addEvent);
app.get('/getEventById',eventRoutes.getEventByID);
app.get('/getAllEvents',eventRoutes.getAllEvents);
app.get('/getParticipants',eventRoutes.getParticipants);
app.get('/deleteEvent',eventRoutes.deleteEvent);
app.put('/updateEvent',eventRoutes.updateEvent);
app.get('/searchEventListByGps', eventRoutes.searchEventListByGps);
app.get('/searchEventListByName',eventRoutes.searchEventListByName);
app.post('/publishEventPerception', eventRoutes.publishEventPerception);
app.post('/publishComment',eventRoutes.publishComment);
app.get('/getEventComments',eventRoutes.getEventComments);
app.put('/setCommentEnabled',eventRoutes.setCommentEnabled);
//routing for user mangement
app.post('/registerAnnonymousUser',userMgmtRoutes.registerAnnonymousUser);
app.post('/registerFBUser',userMgmtRoutes.registerFBUser);
app.post('/authenticateUser',userMgmtRoutes.authenticateUser);
app.put('/updateAnnonymousUser',userMgmtRoutes.updateAnnonymousUser);
app.get('/registerUserForEvent',userMgmtRoutes.registerUserForEvent);
app.get('/getUserById',userMgmtRoutes.getUserById);
app.get('/getSubscribedEvents',userMgmtRoutes.getSubscribedEvents);
app.get('/unsubscribeFromEvent',userMgmtRoutes.removeUserFromEvent);
app.get('/deleteUser',userMgmtRoutes.deleteUser);
http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
}); 