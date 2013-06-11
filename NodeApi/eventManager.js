/**
 * @author Sachintha
 */
exports.addEvent = function(eventID, eventName,eventAdmin, desc, location, startDate,endDate, startTime, endTime,perceptionSchema){
	doc = {eventID:eventID,eventName:eventName,eventAdmin:eventAdmin, description:desc, location:location,
			startDate:startDate,endDate:endDate, startTime:startTime, endTime:endTime, perceptionSchema:perceptionSchema};
	mongoAdapter.insertDocument('EventDetails',doc);
	mongoAdapter.createCollection('EventPerception_'+eventID);
	mongoAdapter.createCollection('EventUser_'+eventID);
};

exports.getEventByID = function(eventID,fn){
     mongoAdapter.getDocuments({eventID: eventID},'EventDetails', function (doc) {
         fn(doc);
     });
};

exports.getAllEvents = function(fn){
    mongoAdapter.getDocuments({}, 'EventDetails', function (doc) {
        fn(doc);
    });
};
exports.deleteEvent = function(eventID){
    mongoAdapter.deleteDocument('EventDetails', {eventID:eventID},function(err){
              if(err)
                console.log(err.message);
    });
    mongoAdapter.dropCollection('EventPerception_'+eventID);
    mongoAdapter.dropCollection('EventUser_'+eventID);
};

exports.getParticipants = function(eventID,fn){
    mongoAdapter.getDocuments({}, 'EventUser_' + eventID, function (docs) {
        fn(docs);
    });
};