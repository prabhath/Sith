/**
 * @author Sachintha
 */
exports.addEvent = function(eventID, eventName, desc, location, date, startTime, endTime,perceptionSchema){
	doc = {eventID:eventID,eventName:eventName, description:desc, location:location,
			date:date, startTime:startTime, endTime:endTime, perceptionSchema:perceptionSchema};
	mongoAdapter.insertDocument('EventDetails',doc);
	mongoAdapter.createCollection('EventPerception_'+eventID);
	mongoAdapter.createCollection('EventUser_'+eventID);
};

exports.getEvent = function(eventID){

};

exports.getAllEvents = function(){
    //
};
exports.deleteEvent = function(eventID){
   //mongoAdaptercall
};

exports.addUserToEvent = function(eventID,userID){
    //
};

exports.removeUserFromEvent = function(eventID,userID){

};